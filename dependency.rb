source = %q[
0   ac_AppealAppendixes
0   ac_AppealBarcodes
0   ac_AppealDecisions
0   ac_AppealExperts
0   ac_AppealTasks
0   ac_AppealVariants
0   ac_CancellationAppendixes
0   ac_Cancellations
0   ac_Changes
0   ac_CorrectionAppendixes
0   ac_PersonCorrectionAppendixes
0   ac_PersonsCorrections
0   ac_RecheckGroups
0   dat_Exams
0   dat_LockDates
0   dat_MarkBorders
0   dat_SchemeVersions
0   dat_Sheets
0   dat_Subjects
0   dat_TestTypes
0   dat_Waves
0   dats_Borders
0   dats_Groups
0   prnf_CertificatePrintMain
0   prnf_CertificatePrintMainMarks
0   prnf_FailurePrints
0   prnf_PressNumbers
0   prnf_Signatures
0   prnr_CertificatePrintMinor
0   prnr_PrintRegisterContents
0   prnr_PrintRegisters
0   rbd_ExportJournal
0   rbd_ImportBackup
0   rbd_ImportJournal
0   rbd_ImportTemplates
0   rbd_RegionRequisites
0   rbd_RegionSettings
0   rbd_StationFormAct
0   rbd_StationFormActHelp
0   rbd_Versions
0   res_Complects
0   res_SubTests
0   sht_Alts
0   sht_Checks
0   sht_ExamFinish
0   sht_FinalMarks_D
0   sht_Marks_D
1   ac_Appeals
1   ac_Corrections
1   ac_Unsticks
1   rbd_CertificateKeys
1   rbd_Certificates
1   rbd_OrganizationRoles
1   rbd_ParticipantsExamsOnRequest
1   rbd_RegionFiles
1   rbd_StuffOrders
1   res_HumanTests
1   scp_RegionQueryGroups
1   sht_Forms
1   sht_Packages
1   sht_Sheets_C
2   ac_AppealIdentities
2   ac_CorrectionIdentities
2   ac_UnstickAppendixes
2   rbd_Areas
2   rbd_CurrentRegion
2   rbd_PCenters
2   rbd_SearchTemplates
2   res_Answers
2   res_Marks
2   sht_FinalMarks_C
2   sht_FormPackages
2   sht_Marks_C
2   sht_Sheets_AB
2   sht_Sheets_D
2   sht_Sheets_R
3   rbd_Address
3   rbd_Governments
3   res_SubComplects
3   sht_Marks_AB
4   rbd_CurrentRegionAddress
4   rbd_Schools
5   rbd_CodeRanges
5   rbd_Experts
5   rbd_Participants
5   rbd_SchoolAddress
5   rbd_Stations
5   rbd_StationWorkers
6   rbd_Auditoriums
6   rbd_CertificatesIssued
6   rbd_ExpertsSubjects
6   rbd_ParticipantProperties
6   rbd_ParticipantsExams
6   rbd_ParticipantsExamsOnRequestDetail
6   rbd_ParticipantsProfSubject
6   rbd_ParticipantsSubject
6   rbd_ReportJournal
6   rbd_SchoolParticipant
6   rbd_StationForm
6   rbd_StationProperties
6   rbd_StationsExams
6   rbd_StationWorkerOnStation
6   rbd_StationWorkerProperties
6   rbd_StationWorkersAccreditation
6   rbd_StationWorkersSubjects
7   rbd_AuditoriumsSubjects
7   rbd_ExamPassport
7   rbd_ExpertsExams
7   rbd_ParticipantExamDecisions
7   rbd_ParticipantsExamsOnSchool
7   rbd_ParticipantsExamsOnStation
7   rbd_Places
7   rbd_StationExamAuditory
7   rbd_StationFormAuditoryFields
7   rbd_StationFormFields
7   rbd_StationsExamsFiles
7   rbd_StationsExamsProperties
8   rbd_ParticipantsExamPStation
8   rbd_StationWorkerOnExam
9   rbd_SeatingProperty
]

source2 = %q["rbd_CurrentRegion",
            "rbd_Governments",
            "rbd_Address",
            "rbd_CurrentRegionAddress",
            "rbd_Areas",
            "rbd_Schools",
            "rbd_SchoolAddress",
            "rbd_Stations",
            "rbd_Auditoriums",
            "rbd_AuditoriumsSubjects",
            "rbd_Places",
            "rbd_StationsExams",
            "rbd_StationExamAuditory",
            "sht_Sheets_C",
            "sht_Sheets_D",
            "res_Complects",
            "res_SubComplects",
            "rbd_Experts",
            "rbd_ExpertsSubjects",
            "rbd_ExpertsExams",
            "sht_Alts",
            "sht_Marks_C",
            "sht_Marks_D",
            "sht_FinalMarks_C",
            "sht_FinalMarks_D",
            "rbd_Participants",
            "rbd_ParticipantsExams",
            "rbd_ParticipantsExamsOnStation",
            "rbd_ParticipantProperties",
            "rbd_ParticipantsExamPStation",
            "prnf_CertificatePrintMain",
            "res_HumanTests",
            "res_SubTests",
            "rbd_StationWorkers",
            "rbd_StationWorkersSubjects",
            "rbd_StationWorkerOnStation",
            "rbd_StationWorkerOnExam",
            "ac_Appeals",
            "ac_AppealTasks",
            "ac_AppealDecisions",
            "ac_AppealExperts",
            "ac_Changes",
            "dats_Borders",
            "dats_Groups",
            "rbd_ParticipantsProfSubject",
            "rbd_ParticipantsSubject",
            "rbd_StationForm",
            "rbd_StationFormAct",
            "rbd_StationFormAuditoryFields",
            "rbd_StationFormFields",
            "rbd_StationWorkersAccreditation",
            "res_Answers",
            "res_Marks",
            "sht_Marks_AB",
            "sht_Packages",
            "sht_Sheets_AB",
            "sht_Sheets_R",
            "ac_Corrections",
            "rbd_ParticipantsExamsOnSchool",
            "rbd_RegionFiles",
            "rbd_SchoolParticipant",
            "sht_ExamFinish"]


# destination = source.split(/\W+/).each_slice(2).to_h
destination = source.split.each_slice(2).map { |x,y| x = y, y = x.to_i}.to_h
puts destination.length

destination.each { |key, v|
    unless source2.include?(key)
        destination.delete(key)
    end
}

# puts destination

template = ""
destination.each { |key, v|
    # puts key
     template += %Q[
        { "#{key}", #{v} }, ]
}

# puts template
File.open('d:\rubies\fooBaa.txt', 'w:windows-1251') {|f| f.write(template) }