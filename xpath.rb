require 'rexml/document'
include REXML

# xmlfile1 = File.new("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/sht_Marks_AB.xml")
xmlfile1 = File.new("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/res_HumanTests.xml")
xmldoc1 = Document.new(xmlfile1)

id1 = []
# xmldoc1.elements.each("/ns1:GIADBSet/ns1:sht_Marks_AB/ns1:SheetFK") { |e| 
xmldoc1.elements.each("/ns1:GIADBSet/ns1:res_HumanTests/ns1:ParticipantFK") { |e| 
   id1 << e.text 
   # puts id1
}

# xmlfile2 = File.new("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/sht_Sheets_AB.xml")
xmlfile2 = File.new("c:/Users/yarnikh/AppData/Local/Temp/Tempdir/rbd_Participants.xml")
xmldoc2 = Document.new(xmlfile2)

id2 = []
# xmldoc2.elements.each("/ns1:GIADBSet/ns1:rbd_Participants/ns1:ParticipantID") { |e| 
xmldoc2.elements.each("/ns1:GIADBSet/ns1:rbd_Participants/ns1:ParticipantID") { |e| 
   id2 << e.text 
   # puts id2
}

id3 = id1 - id2

puts id3