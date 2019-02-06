require "rexml/document"
require 'colorize'

file_name = 'd:\SCREEENSHOOOOTS\52\rbd_StationsExams.xml'

# StationsExamsID => 1
found = {}

file = File.new(file_name, "r")
doc = REXML::Document.new(file)
# doc = REXML::Document.new(File.new('d:\SCREEENSHOOOOTS\52\rbd_StationsExams.xml'))
# deleted = doc.elements["ns1:GIADBSet/ns1:rbd_StationsExams/ns1:IsDeleted"].text
root = doc.root
root.each_element('//ns1:GIADBSet/ns1:rbd_StationsExams/ns1:IsDeleted') do |element| 
    if element.text != '0' 
        puts element.text
    end
end

# deleted.each do |element|
#     if element
# end
file.close()


# found_duplicates.each do |key, value|
#     puts "DUPLICATE #{key}, #{value}".colorize(:color => :white, :background => :red)
# end
