require 'logger'
require 'pathname'
require 'sequel'


@files_db_params = {
  :adapter => 'ado',
  :host => '85.143.100.17',
  :database => 'fct2021-2022',
  :user => 'ftc_dd',
  :password => 'Ljhjujqlheu2015',
  :timeout => 300
}
@erbd_params = {
  :adapter => 'ado',
  :host => '85.143.100.17',
  :database => 'ERBD_DD_2021_2022',
  :user => 'ftc_dd',
  :password => 'Ljhjujqlheu2015',
  :timeout => 300
}



$logger = Logger.new('logs\rollback_' + Time.new.strftime("%Y%m%d_%k%M") + '.log')
$pack_path = "C:\\Files\\2021-2022\\Packages\\Packages\\"
$prot_prot = "C:\\Files\\2021-2022\\Packages\\Protocols\\"
$clients = Array.new

# Загрузка каталогов клиентов
def load_clients_folders()
  #puts("reading packages folder: " + $pack_path + "...");
  pn = Pathname.new($pack_path)
  pn.each_child do |child|
    if File.directory?(child)
      #puts (child)
      #lfldr = child.split("\\").last
      /.*\\([^\\]+)\\/ =~ child.to_s
      lfldr = child.to_s.delete_prefix(Regexp.last_match.to_s)
      #puts (lfldr)
      $clients.push(lfldr)
    end
  end
  puts("Total folders: " + $clients.length.to_s + "...");
end

# открываем файл для чтения перечня пакетов на изъятие
def open_file(fname)
  fnames = Array.new  
  handle = File.new(fname, "r")
  while (line = handle.gets)
    line = line.chomp
    if line.end_with?(".b2p")
      line = line.delete_suffix(".b2p")
    end
    fnames.push(line)
  end
  handle.close
  puts("Read filenames:")
  puts fnames
  return fnames
end

# удаление из БД сервиса загрузок
def delete_from_database(filename)

  db = Sequel.connect(@files_db_params)
  row_count = 0;
  db['select * from dbo.Files where FileName = ?', filename].each do |row|
    row_count += 1
  end
  @exec_params = { :FileName => filename }

  if row_count > 0
     puts("Deleting from files db #{filename}...")
     $logger.info("Removing file from files db: '#{filename}'...")
     db.call_mssql_sproc(:wpsp_RemoveFile, {:args => @exec_params })
  end
  db.disconnect
end

# удаление пакета из ЕРБД 
def delete_from_erbd(filename)
  begin
    @exec_params = { :FileName => filename, :Action => 2 }
    db = Sequel.connect(@erbd_params)
    is_removed = false
    # удаление результатов
    row_count = 0;
    #db['select count(HumanTestID) from dbo.res_HumanTests where FileName = ?', filename].each do |row|
    row_count = db[:res_HumanTests].where(:FileName => filename).count
    if row_count > 0
      #puts("Deleting results for #{filename}...")
      $logger.info("Removing results for package: '#{filename}'...")
      db.call_mssql_sproc('results.ftc_RollbackByFileName', {:args => @exec_params })
      is_removed = true
    else
      $logger.warn("No results data found for package: '#{filename}'...")
    end

  # удаление бланков
  row_count = db[:sht_Packages].where(:FileName => filename).count

  #db['select * from dbo.sht_Packages where FileName = ?', filename].each do |row|
  #  row_count += 1
  #end

  if row_count > 0
     $logger.info("Rolling back package: '#{filename}'...")
     db.call_mssql_sproc(:ftc_RollbackPackage, {:args => @exec_params })
     is_removed = true
  else
     $logger.warn("No sheets data found for package: '#{filename}'...")
  end
  db.disconnect

  if is_removed
     $logger.info("All data for package '#{filename}' is removed")
  end
  rescue => ex
    $logger.fatal("Error has been occured: '" + ex.message + "'")
  end
end

# удаление файла из папки
def delete_file_from_folder(file_name)
  d_code = file_name.chars.take(4).join
  puts("department code is " + d_code);
  fldrs = $clients.select {|fldr| fldr.to_s.include?(d_code) }
  if fldrs.length > 0
    fname = file_name + ".b2p"

    delete_from_database(fname)
    delete_from_erbd(file_name)

    #puts fldrs[0].to_s
    #puts fname

    srch_path = $pack_path + fldrs[0].to_s + "\\" + fname
    if File.exist?(srch_path)
      #puts("Deleting file: " + srch_path  + "...")
      $logger.info("Deleting file: " + srch_path  + "...")
      File.delete(srch_path);
    else
      $logger.warn("File not found: " + srch_path  + "...")
    end
  end
end

# полное изъятие информации о загрузках
def rollback(file_name, for_read)

  to_remove = Array.new
  if for_read
    $logger.info("Rolling back by list from file: '#{file_name}'")
    to_remove = open_file(file_name)
  else
    $logger.info("Rolling back file: '#{file_name}'")
    if file_name.to_s.end_with?(".b2p")
      file_name = file_name.to_s.delete_suffix(".b2p")
    end
    to_remove.push(file_name)
  end

  to_remove.each do |fname|
    puts("removing " + fname + "...")
    delete_file_from_folder(fname)
  end

end

load_clients_folders()

loop do 
  puts("Enter a command:")
  cmd = gets.chomp

  $logger.info("User entered: #{cmd}")
  c_arr = cmd.split
  case c_arr[0]
    when "rollbackfile", "rbfile"
      rollback(c_arr[1], true)
      puts "Done!"
    when "rollback", "rb"
      rollback(c_arr[1], false)
      puts "Done!"
    when "exit", "quit"
      break
    else
     puts "Unknown command: " + cmd
  end
end 

puts("Exiting... bye!")
$logger.info("Program stopped")