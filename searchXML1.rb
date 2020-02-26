require 'nokogiri'

fileSchools = File.open('d:\SCREEEENSHOOOTS\тест\rbd_Schools.xml')
fileSchoolsClasses = File.open('d:\SCREEEENSHOOOTS\тест\rbd_SchoolClasses.xml')

docSchools = Nokogiri::XML(fileSchools)
docSchoolsClasses = Nokogiri::XML(fileSchoolsClasses)

idsSchools = []
idsSchoolsClasses = []

idsSchoolsClassesId = []


docSchools.xpath("//ns1:GIADBSet/ns1:rbd_Schools/ns1:SchoolID").each do |e|
    idsSchools << e.text
    # e.values.each  do |v|
    #     puts v
        # if !e.text.strip.empty? and v.include? "Локальный_ID"  then
        #     puts e.text
        # end
    # end
end

count = 0
docSchoolsClasses.xpath("//ns1:GIADBSet/ns1:rbd_SchoolClasses/ns1:SchoolID").each do |e|
    idsSchoolsClasses << e.text
    count +=1
    # e.values.each  do |v|
    #     puts v
        # if !e.text.strip.empty? and v.include? "Локальный_ID"  then
        #     puts e.text
        # end
    # end
end

docSchoolsClasses.xpath("//ns1:GIADBSet/ns1:rbd_SchoolClasses/ns1:SchoolClassID").each do |e|
    idsSchoolsClassesId << e.text
    count +=1
    # e.values.each  do |v|
    #     puts v
        # if !e.text.strip.empty? and v.include? "Локальный_ID"  then
        #     puts e.text
        # end
    # end
end

idsSchoolsClasses.each do |s|
    unless idsSchools.include? s
        puts s
    end
end


idsSchoolsClassesId.tally.each do |k,v|
    if v > 1
        puts "SchoolClassID: #{k} -- повторов: #{v}"
    end
end

# puts count


fileSchools.close
fileSchoolsClasses.close