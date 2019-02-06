require 'nokogiri'
require 'set'

files = Dir.glob('d:/data/99/**/*.xml')
counter = 0
fcount = 0
# sss = %Q[(]
sss = ""
s = Set.new
files.each do |file_name|
    puts "#{file_name} ********************"
    doc = Nokogiri::XML(File.open(file_name))
    doc.xpath('//Page/Block').each do |element|
        if element.attr('BlockName') =~ /^Фамилия/
            if element.text != ''
                sss << element.text + "\n"
                counter += 1
            end
        end
        # if element.attr('BlockName') =~ /^Код_в_базе/
        #     if element.text != ''
        #         sss << "'" + element.text + "',"
        #     end
        # end
    end
    fcount += 1
end
# sss[-1] = ")"
# File.open('d:\rubies\countxmls.txt', 'w:windows-1251') {|f| f.write(sss) }
puts counter
puts fcount