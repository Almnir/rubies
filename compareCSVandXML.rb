require 'csv'
require 'nokogiri'
require 'pp'

# SchoolID;GovernmentID;SchoolCode;SchoolName;SchoolKindFK;SchoolPropertyFk;AreaFK;TownTypeFK;LawAddress;Address;DPosition;FIO;Phones;Faxs;Mails;People11;People9;ChargeFIO;WWW;LicNum;LicRegNo;LicIssueDate;LicFinishingDate;AccCertNum;AccCertRegNo;AccCertIssueDate;AccCertFinishingDate;isVirtualSchool;SReserve1;SReserve2;DeleteType;IsTOM;REGION;ShortName;TownshipFK;CreateDate;UpdateDate;ImportCreateDate;ImportUpdateDate;SchoolFlags;ChargePhones;ChargeMails;Ogrn;Inn;Kpp

xml_data = File.read("d:/SCREEEENSHOOOTS/60/rbd_Schools1.xml").encode("utf-8", undef: :replace)
# doc = Nokogiri::Slop(xml_data)

# fileSchools = File.open('d:\SCREEEENSHOOOTS\60_FBD (38)\rbd_Schools.xml')

docSchools = Nokogiri::XML(xml_data)

# idsSchools = {}

docSchools.xpath("//ns1:GIADBSet/ns1:rbd_Schools/*").each do |e|
    # idsSchools << e.text
    puts e
    # puts "#{e["ns1:ParticipantID"]}, #{e["ns1:ExamGlobalID"]}, #{e["ns1:IsDeleted"]}"
    # puts "#{e["0"]}"
end

# csv_data = File.read("d:/SCREEEENSHOOOTS/60/60_rbd_Schools.csv").encode("utf-8", undef: :replace)
# # .force_encoding("cp1251").encode("utf-8", undef: :replace)
# CSV.parse(csv_data, encoding:'utf-8', headers: true, col_sep: ';', liberal_parsing: true).each do |x|
#     puts x[0]
# end
