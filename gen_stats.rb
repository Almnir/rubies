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

stats = ""
dir = %q[d:\\data\\Копия 44 таблицы, вариант-4\\]

tablesList.each do |table|
    sqlquery = %Q[SELECT COUNT(*) FROM #{table}]
    result = client.execute(sqlquery)
    size = File.size(dir + table + ".xml")
    stat = size / result.do
    templ_dict = %Q[{ "#{table}", #{stat} }, \n]
    stats += templ_dict
end

File.open('d:\rubies\barBar.txt', 'w:windows-1251') {|f| f.write(stats) }