require 'nokogiri'

file = File.open('d:\SCREEEENSHOOOTS\76002090-06-760406-008-20190213.xml')

doc = Nokogiri::XML(file)

doc.xpath("batch/Page/Block").each do |e|
    e.values.each  do |v|
        if !e.text.strip.empty? and v.include? "Локальный_ID"  then
            puts e.text
        end
    end
end

file.close