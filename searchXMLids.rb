require 'nokogiri'

fileSchools = File.open('d:\SCREEEENSHOOOTS\60_FBD (38)\rbd_Schools.xml')
fileStations = File.open('d:\SCREEEENSHOOOTS\60_FBD (38)\rbd_Stations.xml')

docSchools = Nokogiri::XML(fileSchools)
docStations = Nokogiri::XML(fileStations)

idsSchools = []
idsStations = []

# puts "SCHOOLS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

docSchools.xpath("//ns1:GIADBSet/ns1:rbd_Schools/ns1:SchoolID").each do |e|
    idsSchools << e.text
    # puts e
    # puts "#{e["ns1:ParticipantID"]}, #{ExamGlobalID}, #{IsDeleted}"
end

# puts "STATIONS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

docStations.xpath("//ns1:GIADBSet/ns1:rbd_Stations/ns1:SchoolFK").each do |e|
    idsStations << e.text
    # puts e
    # puts "#{e["ns1:ParticipantID"]}, #{ExamGlobalID}, #{IsDeleted}"
end

fileSchools.close
fileStations.close

puts "-----------------------------------------------------------------"

count = 0
idsStations.each do |s|
    unless idsSchools.include? s
        puts s
        count +=1
    end
end
puts "Итого: #{count}"

# idsSchoolsClasses.each do |s|
#     unless idsSchools.include? s
#         puts s
#     end
# end


# idsSchoolsClassesId.tally.each do |k,v|
#     if v > 1
#         puts "SchoolClassID: #{k} -- повторов: #{v}"
#     end
# end

# puts count


