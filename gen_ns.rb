require 'tiny_tds'

tablesList = ["ac_Appeals",
"ac_AppealTasks",
"ac_Changes",
"dats_Borders",
"dats_Groups",
"prnf_CertificatePrintMain",
"rbd_Address",
"rbd_Areas",
"rbd_Auditoriums",
"rbd_AuditoriumsSubjects",
"rbd_CurrentRegion",
"rbd_CurrentRegionAddress",
"rbd_Experts",
"rbd_ExpertsExams",
"rbd_ExpertsSubjects",
"rbd_Governments",
"rbd_ParticipantProperties",
"rbd_Participants",
"rbd_ParticipantsExamPStation",
"rbd_ParticipantsExams",
"rbd_ParticipantsExamsOnStation",
"rbd_ParticipantsProfSubject",
"rbd_ParticipantsSubject",
"rbd_Places",
"rbd_SchoolAddress",
"rbd_Schools",
"rbd_StationExamAuditory",
"rbd_StationForm",
"rbd_StationFormAct",
"rbd_StationFormAuditoryFields",
"rbd_StationFormFields",
"rbd_Stations",
"rbd_StationsExams",
"rbd_StationWorkerOnExam",
"rbd_StationWorkerOnStation",
"rbd_StationWorkers",
"rbd_StationWorkersAccreditation",
"rbd_StationWorkersSubjects",
"res_Answers",
"res_Complects",
"res_HumanTests",
"res_Marks",
"res_SubComplects",
"res_Subtests",
"sht_Alts",
"sht_FinalMarks_C",
"sht_FinalMarks_D",
"sht_Marks_AB",
"sht_Marks_C",
"sht_Marks_D",
"sht_Packages",
"sht_Sheets_AB",
"sht_Sheets_C",
"sht_Sheets_D",
"sht_Sheets_R"]

client = TinyTds::Client.new username: 'ra', password: 'Njkmrjcdjb', host: '10.0.18.3', port: 1433, database: 'erbd_gia_reg_17_77', azure:false

proper_string = ""

tablesList.each do |table|

    proper_table = %Q[bcp ";WITH XMLNAMESPACES('http://www.rustest.ru/giadbset' as ns1) SELECT ]
    # proper_table = %Q[{ "#{table}", "WITH XMLNAMESPACES('http://www.rustest.ru/giadbset' as ns1) SELECT ]

    sqlquery = %Q[SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('dbo.#{table}')]
    table_columns = ""
    results = client.execute(sqlquery)  
    results.each do |row|  
        col = row["name"]
        table_columns += "#{col} as 'ns1:#{col}',"
    end
    table_columns.chomp!(",")

    proper_table += table_columns
    proper_table += %Q[ FROM #{table} FOR XML PATH('ns1:#{table}'), ROOT('ns1:GIADBSet') " queryout #{table}1.xml -c -r -CACP -S "101.10.1.13" -d "erbd_gia" -U"user" -P"password" \n]
    # proper_table += %Q[ FROM #{table} FOR XML PATH('ns1:#{table}'), ROOT('ns1:GIADBSet'); "}, \n]

    proper_string +=proper_table
end

client.close

proper_string += "\n"
tablesList.each do |table|
    proper_string += %Q[powershell.exe -ExecutionPolicy Bypass -Command "Get-Content -Encoding default #{table}1.xml | Out-File -Encoding UTF8 #{table}.xml"\n]
end
proper_string += %Q[powershell.exe -ExecutionPolicy Bypass -Command "get-childitem | where {$_.length -eq 0} | remove-item"\n]
proper_string += %Q[powershell.exe -ExecutionPolicy Bypass -Command "Remove-Item *1.xml"\n]

File.open('d:\rubies\fooFOO.bat', 'w:windows-1251') {|f| f.write(proper_string) }

# columns = %Q[
# [AddressID]
#       ,[REGION]
#       ,[ZipCode]
#       ,[LocalityTypeID]
#       ,[LocalityName]
#       ,[StreetTypeID]
#       ,[StreetName]
#       ,[BuildingTypeID]
#       ,[BuildingNumber]
#       ,[TownshipID]
#       ,[CreateDate]
#       ,[UpdateDate]
#       ,[ImportCreateDate]
#       ,[ImportUpdateDate]
#       ,[IsDeleted]
# ]

# colmas = columns.split(",")
# puts colmas.to_s
# result = ""
# colmas.each do |x|
#     striped = x.delete("[]\n").strip
#     result += "#{striped} as 'ns1:#{striped}',\n"
# end
# result.chomp!(",\n")
# puts result
# File.open('d:\rubies\fooFOO.txt', 'w:windows-1251') {|f| f.write(result) }

# bcp ";WITH XMLNAMESPACES('http://www.rustest.ru/giadbset' as ns1) SELECT REGION as 'ns1:REGION', AppealID as 'ns1:AppealID', HumanTestFK as 'ns1:HumanTestFK', AppealType as 'ns1:AppealType', DeclinedByCommittee as 'ns1:DeclinedByCommittee', CreateTime as 'ns1:CreateTime',UpdateTime as 'ns1:UpdateTime',InProcess as 'ns1:InProcess',AppealCondition as 'ns1:AppealCondition',WorkStation as 'ns1:WorkStation',AppealComment as 'ns1:AppealComment'FROM ac_Appeals FOR XML PATH('ns1:ac_Appeals'), ROOT('ns1:GIADBSet')" queryout dd.xml -c -CACP -S "10.0.18.3" -d "ERBD_EGE_MAIN_16__2016_09_26" -Ura -PNjkmrjcdjb