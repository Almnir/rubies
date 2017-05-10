require 'nokogiri'

# Dir.glob('*.xsd') do |f|

doc = File.open("ArrayOfAltsDto.xsd") { |f| Nokogiri::XML(f) }

doc.xpath('//element').each do |al|
    puts al.at_xpath('element').content
end

# end