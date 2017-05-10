exit if defined? Ocra

if ARGV[0].nil? or ARGV[1].nil?
    puts "compare [Путь к каталогу источника] [Путь к каталогу назначения]"
    exit
end

sourceDir = ARGV[0].to_s.gsub('\\','/').gsub(/^\//,'//')
destDir = ARGV[1].to_s.gsub('\\','/').gsub(/^\//,'//')

# проходим по подкаталогам исходного каталога
Dir.glob(File.join(sourceDir, '**')) do |soDir|
    next if sourceDir == soDir
    # puts "#{sourceDir}, #{soDir}, **/*.* исходный каталог взят"

    # проходим по файлам подкаталога
    Dir.glob(File.join(soDir, '**', '*.*')) do |soFile|
        lastSourceNum = soFile.split('.').first(1).join.split('_').last(1).first
        # если не число в конце имени, то следующий
        if lastSourceNum !~ /[a-z]*[0-9]+$/
            next
        end
        puts "#{soFile} исходный файл выбран"
        # каталог назначения
        doDir = soDir.split('/').last
        count = 0
        puts "каталог назначения - #{destDir}#{doDir}"
        # ищем с таким же на конце в подкаталогах каталога назначения
        Dir.glob(File.join(destDir, doDir, '**', '*.*')) do |deFile|
            # puts "#{deFile} файл назначения взят"
            lastDestNum = deFile.split('.').first(1).join.split('_').last(1).first
            # если не число в конце имени, то следующий
            if lastDestNum !~ /[a-z]*[0-9]+$/
                next
            elsif lastDestNum == lastSourceNum
                 count += 1   
            end
        end
        if count == 0
            puts "#{soFile} не найдено соответствий"
        else
            puts "#{count} соответствий найдено"
        end
    end
end