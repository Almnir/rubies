# First set the files to search/replace in
files = Dir.glob("*.xml")

# Then set the variables for find/replace
@original_string1 = %Q[<ns1:REGION>19</ns1:REGION>]
@replacement_string1 = %Q[<ns1:REGION>52</ns1:REGION>]
@original_string2 = %Q[<ns1:Region>19</ns1:Region>]
@replacement_string2 = %Q[<ns1:Region>52</ns1:Region>]
# @original_string2 = /</xs:complexType>
#  </xs:element>/
#@replacement_string2 = %Q[</xs:complexType>
#  ]


counter = 0
files.each do |file_name|
  # file_name = "GiaSet.xsd"
  text = File.read(file_name)
  # puts file_name
  replace1 = text.gsub!(@original_string2, @replacement_string2)
  if !replace1.nil? && !replace1.empty?
  #   replace2 = replace1.gsub!(@original_string2, @replacement_string2)
    File.open(file_name, "w") { |file| file.puts replace1 }
    counter += 1
  end
  # File.open(file_name, "w") { |file| file.puts replace1 }
end

puts counter