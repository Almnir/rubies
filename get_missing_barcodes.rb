arr = []
matchString = 'Не найден муниципалитет по коду'

File.open('d:\SCREEEENSHOOOTS\inna\missing_codes.txt').each do |line|
    if line.include?(matchString) then
        arr << line.split(' ').first
    end
end
result = arr.join("\n")
File.open('d:\SCREEEENSHOOOTS\inna\barcodes.txt', 'w:windows-1251') {|f| f.write(result) }