require 'csv'

BARCODE = 'Код_1'
IMAGE_NUMBER = 'Номер_изображения'
BASEDIR = 'd:/17/50'
dup_count = 0
hashmap = {}

Dir.glob(BASEDIR + '/**/*.csv') do |file|
    filedata = File.read(file).force_encoding("cp1251").encode("utf-8", undef: :replace)
    CSV.parse(filedata, encoding:'utf-8', headers: true, col_sep: ';').each do |x|
        unless hashmap.include? x[BARCODE]
            hashmap[x[BARCODE]] = [x[IMAGE_NUMBER], file]
        else
            hashmap[x[BARCODE]] << x[IMAGE_NUMBER] << file
        end
    end
end

hashmap.reject {|k,v| v.length == 2 }.each do |key, value| 
    puts "штрихкод #{key}" 
    value.each_slice(2).to_a.each do |inum, filename|
        puts "название #{File.basename(filename)} номер изображения #{inum}" 
    end
    dup_count += 1
end
puts "Найдено #{dup_count} дублей" unless dup_count == 0
puts "Всего #{hashmap.length} записей"