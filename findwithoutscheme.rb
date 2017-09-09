require 'colorize'

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

count = 1
countMatch = 0
File.open('d:/Scripts/loader.Synchronize.sql').each do |line|
    foundtable = tablesList.select {|x| line.downcase.index(x.downcase)}
    foundtable.each do |ftable|
        idx = line.index(ftable.to_s)
        idx -= 1
        idc = line.index("--")
        if line[idx] != '.' && line[idx] != "'" && (idc == nil || idc >= idx)
            puts "no scheme! row #{count}: , #{line}".colorize(:color => :brown, :background => :yellow)
            countMatch += 1
        end
    end
    count += 1
end
puts "summary: #{countMatch}"