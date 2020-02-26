pluralTables = {"ac_Appeals" => "ac_Appeal",
"ac_AppealTasks" => "ac_AppealTask",
"ac_AppealDecisions" => "ac_AppealDecision",
"ac_AppealExperts" => "ac_AppealExpert",
"ac_Changes" => "ac_Change",
"dats_Borders" => "dats_Border",
"dats_Groups" => "dats_Group",
"prnf_CertificatePrintMains" => "prnf_CertificatePrintMain",
"rbd_Addresses" => "rbd_Address",
"rbd_Areas" => "rbd_Area",
"rbd_Auditoriums" => "rbd_Auditorium",
"rbd_AuditoriumsSubjects" => "rbd_AuditoriumsSubject",
"rbd_CurrentRegions" => "rbd_CurrentRegion",
"rbd_CurrentRegionAddresses" => "rbd_CurrentRegionAddress",
"rbd_Experts" => "rbd_Expert",
"rbd_ExpertsExams" => "rbd_ExpertsExam",
"rbd_ExpertsSubjects" => "rbd_ExpertsSubject",
"rbd_Governments" => "rbd_Government",
"rbd_Participants" => "rbd_Participant",
"rbd_ParticipantProperties" => "rbd_ParticipantProperty",
"rbd_ParticipantsExams" => "rbd_ParticipantsExam",
"rbd_ParticipantsExamPStations" => "rbd_ParticipantsExamPStation",
"rbd_ParticipantsExamsOnStations" => "rbd_ParticipantsExamsOnStation",
"rbd_ParticipantsProfSubjects" => "rbd_ParticipantsProfSubject",
"rbd_ParticipantsSubjects" => "rbd_ParticipantsSubject",
"rbd_Places" => "rbd_Place",
"rbd_Schools" => "rbd_School",
"rbd_SchoolAddresses" => "rbd_SchoolAddress",
"rbd_Stations" => "rbd_Station",
"rbd_StationExamAuditories" => "rbd_StationExamAuditory",
"rbd_StationForms" => "rbd_StationForm",
"rbd_StationFormActs" => "rbd_StationFormAct",
"rbd_StationFormAuditoryFields" => "rbd_StationFormAuditoryField",
"rbd_StationFormFields" => "rbd_StationFormField",
"rbd_StationsExams" => "rbd_StationsExam",
"rbd_StationWorkers" => "rbd_StationWorker",
"rbd_StationWorkerOnExams" => "rbd_StationWorkerOnExam",
"rbd_StationWorkerOnStations" => "rbd_StationWorkerOnStation",
"rbd_StationWorkersAccreditations" => "rbd_StationWorkersAccreditation",
"rbd_StationWorkersSubjects" => "rbd_StationWorkersSubject",
"res_Answers" => "res_Answer",
"res_Complects" => "res_Complect",
"res_HumanTests" => "res_HumanTest",
"res_Marks" => "res_Mark",
"res_SubComplects" => "res_SubComplect",
"res_SubTests" => "res_SubTest",
"sht_Alts" => "sht_Alt",
"sht_ExamFinish" => "sht_ExamFinish",
"sht_FinalMarks_C" => "sht_FinalMarks_C",
"sht_FinalMarks_D" => "sht_FinalMarks_D",
"sht_Marks_AB" => "sht_Marks_AB",
"sht_Marks_C" => "sht_Marks_C",
"sht_Marks_D" => "sht_Marks_D",
"sht_Packages" => "sht_Package",
"sht_Sheets_AB" => "sht_Sheets_AB",
"sht_Sheets_C" => "sht_Sheets_C",
"sht_Sheets_D" => "sht_Sheets_D",
"sht_Sheets_R" => "sht_Sheets_R",
"ac_Corrections" => "ac_Correction",
"rbd_ParticipantsExamsOnSchool" => "rbd_ParticipantsExamsOnSchool",
"rbd_RegionFiles" => "rbd_RegionFiles",
"rbd_SchoolParticipant" => "rbd_SchoolParticipant"}

pluralTables.each do |tables, table|
    bulkClassTemplate = %Q[
using GiaImport.DataModels;
using LinqToDB;
using LinqToDB.Data;
using LinqToDB.DataProvider.SqlServer;
using System;
using System.Collections.Generic;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Serialization;

namespace TestConsoleApp.BulkClasses
{
    public static class Bulk_@tables
    {
        public static void BulkImportTables(string connectionString, string fileName)
        {
            try
            {
                using (var dc = SqlServerTools.CreateDataConnection(connectionString))
                using (var db = new GIA_DB(dc.DataProvider, connectionString))
                {
                    using (XmlReader reader = XmlReader.Create(fileName))
                    {
                        reader.ReadToDescendant("ns1:@tables");
                        do
                        {
                            ITable<@table> table = db.GetTable<@table>().SchemaName("loader");
                            BulkCopyRowsCopied bcrc = null;
                            BulkCopyOptions bco = new BulkCopyOptions();
                            bco.BulkCopyTimeout = 300000000;
                            bco.BulkCopyType = BulkCopyType.Default;
                            bco.MaxBatchSize = 5000;
                            bco.RowsCopiedCallback += (rows) =>
                            {
                                Console.WriteLine(string.Format("Imported rows: {0}", rows.RowsCopied.ToString()));
                            };
                            bco.NotifyAfter = 50000;
                            bcrc = table.BulkCopy(bco, GetData(reader));

                        } while (!reader.EOF);
                    }

                }
            }
            catch (Exception ex)
            {
                if (ex.InnerException is OperationCanceledException)
                {
                    throw new OperationCanceledException();
                }
                string status = string.Format("При импорте таблицы произошла ошибка {0}.", ex.ToString());
                throw new Exception();
            }
        }

        private static IEnumerable<@table> GetData(XmlReader reader)
        {
            do
            {
                var serializer = new XmlSerializer(typeof(@table));

                string s = reader.ReadOuterXml().Replace(" xmlns:ns1=\\"http://www.rustest.ru/giadbset\\"", "").Replace("ns1:", "").Replace("@tables", "@table");
                if (s.Length == 0)
                {
                    break;
                }
                XDocument xmlDoc = XDocument.Parse(s);

                @table result = (@table)serializer.Deserialize(xmlDoc.CreateReader());

                yield return result;

            }
            while (reader.ReadToNextSibling("ns1:@tables") && !reader.EOF);
        }

    }
}

    ]
    bulkClassTemplate.gsub!("@tables", tables)
    bulkClassTemplate.gsub!("@table", table)
    puts "#{tables} - #{table}"
    File.open("d:\\1\\222\\Bulk_#{tables}.cs", 'w:windows-1251') {|f| f.write(bulkClassTemplate) }
end