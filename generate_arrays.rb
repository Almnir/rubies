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

tableList = ["ac_Appeal",
"ac_AppealTask",
"ac_Change",
"dats_Border",
"dats_Group",
"prnf_CertificatePrintMain",
"rbd_Address",
"rbd_Area",
"rbd_Auditorium",
"rbd_AuditoriumsSubject",
"rbd_CurrentRegion",
"rbd_CurrentRegionAddress",
"rbd_Expert",
"rbd_ExpertsExam",
"rbd_ExpertsSubject",
"rbd_Government",
"rbd_ParticipantProperty",
"rbd_Participant",
"rbd_ParticipantsExamPStation",
"rbd_ParticipantsExam",
"rbd_ParticipantsExamsOnStation",
"rbd_ParticipantsProfSubject",
"rbd_ParticipantsSubject",
"rbd_Place",
"rbd_SchoolAddress",
"rbd_School",
"rbd_StationExamAuditory",
"rbd_StationForm",
"rbd_StationFormAct",
"rbd_StationFormAuditoryField",
"rbd_StationFormField",
"rbd_Station",
"rbd_StationsExam",
"rbd_StationWorkerOnExam",
"rbd_StationWorkerOnStation",
"rbd_StationWorker",
"rbd_StationWorkersAccreditation",
"rbd_StationWorkersSubject",
"res_Answer",
"res_Complect",
"res_HumanTest",
"res_Mark",
"res_SubComplect",
"res_SubTest",
"sht_Alt",
"sht_FinalMarks_C",
"sht_FinalMarks_D",
"sht_Marks_AB",
"sht_Marks_C",
"sht_Marks_D",
"sht_Package",
"sht_Sheets_AB",
"sht_Sheets_C",
"sht_Sheets_D",
"sht_Sheets_R"]

text = ""

# tablesList.zip(tableList).each do |tables, table|
#     template = %Q[
#         [Serializable()]
#         [DebuggerStepThrough()]
#         [DesignerCategory("code")]
#         [XmlType(AnonymousType = false, IncludeInSchema = true, Namespace = "http://www.rustest.ru/giadbset")]
#         [XmlRoot(Namespace = "http://www.rustest.ru/giadbset", IsNullable = true, ElementName = "GIADBSet")]
#         public class #{tables}Set
#         {

#             private #{table}[] itemsField;

#             [XmlElement("#{tables}", Form = System.Xml.Schema.XmlSchemaForm.Qualified)]
#             public #{table}[] Items
#             {
#                 get
#                 {
#                     return this.itemsField;
#                 }
#                 set
#                 {
#                     this.itemsField = value;
#                 }
#             }
#         }
#     ]

#     text << template
# end
# File.open('d:\rubies\fooarr.txt', 'w:windows-1251') {|f| f.write(text) }

tablesList.zip(tableList).each do |tables, table|

# tablesList.each do |tables|
# template = %Q[
#         public static void Bulkload_#{tables}(string xmlfilename, Action<BulkCopyRowsCopied> handler)
#         {
#             new Bulkload<#{tables}Set, #{table}>().Load(MainStage.DeserializeXMLFileToObject<#{tables}Set>(xmlfilename).Items, "#{tables}", handler);
#         }    
#     ]

# template = %Q[
#         public void Bulkload_#{tables}(string xmlfilename, Action<BulkCopyRowsCopied> handler, out ConcurrentDictionary<string, Tuple<string, long, TimeSpan>> outParam)
#         {
#             Bulkload<#{tables}Set, #{table}> bl = new Bulkload<#{tables}Set, #{table}>();
#             bl.Load(MainStage.DeserializeXMLFileToObject<#{tables}Set>(xmlfilename).Items, "#{tables}", handler);
#             outParam = bl.errorDict;
#         }
#     ]

template = %Q[
                case "#{tables}":
                    Bulkload_#{tables}(xmlfilename, handler, out outParam);
                    break;
            ]

# template = %Q[
# case "#{tables}":
#                     query = @"
                    
#                     ";
#                     break;
# ]
    text << template
end
File.open('d:\rubies\fooarr5.txt', 'w:windows-1251') {|f| f.write(text) }