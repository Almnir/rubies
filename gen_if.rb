tablesList = %Q[ac_Appeals
            ac_AppealTasks
            ac_AppealDecisions
            ac_AppealExperts
            ac_Changes
            dats_Borders
            dats_Groups
            prnf_CertificatePrintMain
            rbd_Address
            rbd_Areas
            rbd_Auditoriums
            rbd_AuditoriumsSubjects
            rbd_CurrentRegion
            rbd_CurrentRegionAddress
            rbd_Experts
            rbd_ExpertsExams
            rbd_ExpertsSubjects
            rbd_Governments
            rbd_ParticipantProperties
            rbd_Participants
            rbd_ParticipantsExamPStation
            rbd_ParticipantsExams
            rbd_ParticipantsExamsOnStation
            rbd_ParticipantsProfSubject
            rbd_ParticipantsSubject
            rbd_Places
            rbd_SchoolAddress
            rbd_Schools
            rbd_StationExamAuditory
            rbd_StationForm
            rbd_StationFormAct
            rbd_StationFormAuditoryFields
            rbd_StationFormFields
            rbd_Stations
            rbd_StationsExams
            rbd_StationWorkerOnExam
            rbd_StationWorkerOnStation
            rbd_StationWorkers
            rbd_StationWorkersAccreditation
            rbd_StationWorkersSubjects
            res_Answers
            res_Complects
            res_HumanTests
            res_Marks
            res_SubComplects
            res_SubTests
            sht_Alts
            sht_FinalMarks_C
            sht_FinalMarks_D
            sht_Marks_AB
            sht_Marks_C
            sht_Marks_D
            sht_Packages
            sht_Sheets_AB
            sht_Sheets_C
            sht_Sheets_D
            sht_Sheets_R
            ac_Corrections
            rbd_ParticipantsExamsOnSchool
            rbd_RegionFiles
            rbd_SchoolParticipant
            sht_ExamFinish]

result = ""

tablesList.split.each do |table|
    sqlquery = %Q[
SELECT COUNT(*) as #{table} FROM dbo.#{table}
]
    result += sqlquery
end

File.open('d:\rubies\barBarIF.txt', 'w:windows-1251') {|f| f.write(result) }