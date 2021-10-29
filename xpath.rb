require 'rexml/document'
include REXML

id1 = []
File.open("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/res_HumanTests.xml", "r") do |f|
   Document.new(f).elements.each("/ns1:GIADBSet/ns1:res_HumanTests/ns1:ParticipantFK") do |e| 
      id1 << e.text 
   end
end

id2 = []
File.open("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/rbd_Participants.xml", "r") do |f|
   Document.new(f).elements.each("/ns1:GIADBSet/ns1:rbd_Participants/ns1:ParticipantID") do |e| 
      id2 << e.text 
   end
end

id3 = id1 - id2

puts id3