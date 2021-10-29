require 'csv'
require 'clipboard'

# REGCODE = 'Код представительство'
# это прикол
REGCODE = 0

BASEDIR = 'd:/Доступ/'

MESSAGE_HEADER = 'Здравствуйте!'

# список файлов в подкаталоге по времени модификации
files_sorted_by_time = Dir.glob(BASEDIR + '/**/*.csv').sort_by{ |f| File.mtime(f) }

# последний файл
file_name = files_sorted_by_time.last

# читаем последний модифицированный преобразуя кодировку
filedata = File.read(file_name).force_encoding("cp1251").encode("utf-8", undef: :replace)

message = %Q[
Доступ по "#{file_name}" предоставлен для представительств: ]

CSV.parse(filedata, encoding:'utf-8', headers: true, col_sep: ';').each do |x|
    message += x[REGCODE]
    message += ', '
end
message[-2] = '.'
puts MESSAGE_HEADER
puts message
Clipboard.copy(MESSAGE_HEADER + message)