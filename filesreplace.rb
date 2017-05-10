# First set the files to search/replace in
files = Dir.glob("*.xsd")

# Then set the variables for find/replace
@original_string1 = %Q[((000[1-9])|(00[1-9][0-9])|(0[1-9][0-9]{2})|([1-9][0-9]{3}))-((0[1-9])|(1[012]))-((0[1-9])|([12][0-9])|(3[01])).{1}(([01][0-9])|(2[0-3]))(:[0-5][0-9]){2}(\.[0-9]{2}[037])?]
@replacement_string1 = %Q[(\d{4})-(\d{2})-(\d{2})(.{1})(\d{2}):(\d{2}):(\d{2}).(\d{3})]
# @original_string2 = /</xs:complexType>
#  </xs:element>/
#@replacement_string2 = %Q[</xs:complexType>
#  ]

files.each do |file_name|
  # file_name = "GiaSet.xsd"
  text = File.read(file_name)
  # puts file_name
  # replace1 = text.gsub!(@original_string1, @replacement_string1)
  if text.
  # replace2 = replace1.gsub!(@original_string2, @replacement_string2) unless replace1 == nil
  File.open(file_name, "w") { |file| file.puts replace1 }
end