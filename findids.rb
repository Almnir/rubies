files = Dir.glob("*.xsd")

@original_string = "System.Guid"
lines_count = 0

files.each do |file_name|
  puts "#{file_name} ********************"
  File.open(file_name).each do |line|
    if line.match(@original_string) then
      puts line
      lines_count += 1
    end
  end
  puts "********************************* : #{lines_count}"
  lines_count = 0
  # replace1 = text.gsub!(@original_string1, @replacement_string1)
  # replace2 = replace1.gsub!(@original_string2, @replacement_string2) unless replace1 == nil
  # File.open(file_name, "w") { |file| file.puts replace2 }
end