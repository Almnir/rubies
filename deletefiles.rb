require 'roo'

# номер колонки с именами файлов
COLUMN_INDEX = 2
# директория в которой нужно удалить файлы
DIRECTORY = 'j:\fff\test'

xlsx = Roo::Excelx.new('j:\Documents\Files.xlsx')

xlsx.column(COLUMN_INDEX).each do |row|
    File.delete(File.join(DIRECTORY, row))
end