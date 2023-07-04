require 'fileutils'
require "java"
require 'sequel'
require 'd:/rubies/sqljdbc42.jar'
Java::com.microsoft.sqlserver.jdbc.SQLServerDriver

class GenerateLoaders
    def initialize
        @db_connection_params = {
            :adapter => "jdbc",
            :username => 'ra',
            :password => 'Njkmrjcdjb',
            :host => "10.0.18.7",
            :database => "erbd_gia_reg_23_90",    
            :url => "jdbc:sqlserver://10.0.18.7:1433;DatabaseName=erbd_gia_reg_23_90;integratedSecurity=false;encrypt=false;trustServerCertificate=true;",
            :timeout => 300
        }
        @tablesList = [
            "ac_AppealDecisions",
            "ac_AppealExperts",
            "ac_Appeals",
            "ac_AppealTasks",
            "ac_Changes",
            "ac_Corrections",
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
            "rbd_ParticipantClasses",
            "rbd_ParticipantProperties",
            "rbd_Participants",
            "rbd_ParticipantsExamPStation",
            "rbd_ParticipantsExams",
            "rbd_ParticipantsExamsOnSchool",
            "rbd_ParticipantsExamsOnStation",
            "rbd_ParticipantsProfSubject",
            "rbd_ParticipantsSubject",
            "rbd_Places",
            "rbd_RegionFiles",
            "rbd_SchoolAddress",
            "rbd_SchoolClasses",
            "rbd_SchoolParticipant",
            "rbd_Schools",
            "rbd_StationExamAuditory",
            "rbd_StationExamAuditoryProps",
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
            "rbd_StationWorkersPositions",
            "res_Answers",
            "res_Complects",
            "res_HumanTests",
            "res_Marks",
            "res_SubComplects",
            "res_Subtests",
            "sht_Alts",
            "sht_ExamFinish",
            "sht_FinalMarks_C",
            "sht_FinalMarks_D",
            "sht_Marks_AB",
            "sht_Marks_C",
            "sht_Marks_D",
            "sht_Packages",
            "sht_Sheets_AB",
            "sht_Sheets_C",
            "sht_Sheets_D",
            "sht_Sheets_R",
            "rbd_AuditoriumParallels",
            "rbd_ExpertParallels",
            "rbd_StationParallels",
            "rbd_StationWorkerParallels"
        ]
    end
    def Generate
        db = Sequel.connect(@db_connection_params)
        @tablesList.each do |table|
            query_template = %Q[
                        DECLARE  
                        @object_name SYSNAME  
                    , @object_id INT  
                    , @SQL NVARCHAR(MAX)  
                    
                SELECT  
                        @object_name = '[' + OBJECT_SCHEMA_NAME(o.[object_id]) + '].[' + OBJECT_NAME([object_id]) + ']'  
                    , @object_id = [object_id]  
                FROM (SELECT [object_id] = OBJECT_ID('dbo.#{table}', 'U')) o  
                    
                SELECT @SQL = 'CREATE TABLE ' + @object_name + CHAR(13) + '(' + CHAR(13) + STUFF((  
                    SELECT CHAR(13) + '    , [' + c.name + '] ' +   
                        CASE WHEN c.is_computed = 1  
                            THEN 'AS ' + OBJECT_DEFINITION(c.[object_id], c.column_id)  
                            ELSE   
                                CASE WHEN c.system_type_id != c.user_type_id   
                                    THEN '[' + SCHEMA_NAME(tp.[schema_id]) + '].[' + tp.name + ']'   
                                    ELSE '[' + UPPER(tp.name) + ']'   
                                END  +   
                                CASE   
                                    WHEN tp.name IN ('varchar', 'char', 'varbinary', 'binary')  
                                        THEN '(' + CASE WHEN c.max_length = -1   
                                                        THEN 'MAX'   
                                                        ELSE CAST(c.max_length AS VARCHAR(5))   
                                                    END + ')'  
                                    WHEN tp.name IN ('nvarchar', 'nchar')  
                                        THEN '(' + CASE WHEN c.max_length = -1   
                                                        THEN 'MAX'   
                                                        ELSE CAST(c.max_length / 2 AS VARCHAR(5))   
                                                    END + ')'  
                                    WHEN tp.name IN ('datetime2', 'time2', 'datetimeoffset')   
                                        THEN '(' + CAST(c.scale AS VARCHAR(5)) + ')'  
                                    WHEN tp.name = 'decimal'  
                                        THEN '(' + CAST(c.[precision] AS VARCHAR(5)) + ',' + CAST(c.scale AS VARCHAR(5)) + ')'  
                                    ELSE ''  
                                END +  
                                CASE WHEN c.collation_name IS NOT NULL AND c.system_type_id = c.user_type_id   
                                    THEN ' COLLATE ' + c.collation_name  
                                    ELSE ''  
                                END +  
                                CASE WHEN c.is_nullable = 1   
                                    THEN ' NULL'  
                                    ELSE ' NOT NULL'  
                                END +  
                                CASE WHEN c.default_object_id != 0   
                                    THEN ' CONSTRAINT [' + OBJECT_NAME(c.default_object_id) + ']' +   
                                        ' DEFAULT ' + OBJECT_DEFINITION(c.default_object_id)  
                                    ELSE ''  
                                END +   
                                CASE WHEN cc.[object_id] IS NOT NULL   
                                    THEN ' CONSTRAINT [' + cc.name + '] CHECK ' + cc.[definition]  
                                    ELSE ''  
                                END +  
                                CASE WHEN c.is_identity = 1   
                                    THEN ' IDENTITY(' + CAST(IDENTITYPROPERTY(c.[object_id], 'SeedValue') AS VARCHAR(5)) + ',' +   
                                                    CAST(IDENTITYPROPERTY(c.[object_id], 'IncrementValue') AS VARCHAR(5)) + ')'   
                                    ELSE ''   
                                END   
                        END  
                    FROM sys.columns c WITH(NOLOCK)  
                    JOIN sys.types tp WITH(NOLOCK) ON c.user_type_id = tp.user_type_id  
                    LEFT JOIN sys.check_constraints cc WITH(NOLOCK)   
                        ON c.[object_id] = cc.parent_object_id   
                        AND cc.parent_column_id = c.column_id  
                    WHERE c.[object_id] = @object_id  
                    ORDER BY c.column_id  
                    FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 7, '      ') +   
                    ISNULL((SELECT '  
                    , CONSTRAINT [' + i.name + '] PRIMARY KEY ' +   
                    CASE WHEN i.index_id = 1   
                        THEN 'CLUSTERED'   
                        ELSE 'NONCLUSTERED'   
                    END +' (' + (  
                    SELECT STUFF(CAST((  
                        SELECT ', [' + COL_NAME(ic.[object_id], ic.column_id) + ']' +  
                                CASE WHEN ic.is_descending_key = 1  
                                    THEN ' DESC'  
                                    ELSE ''  
                                END  
                        FROM sys.index_columns ic WITH(NOLOCK)  
                        WHERE i.[object_id] = ic.[object_id]  
                            AND i.index_id = ic.index_id  
                        FOR XML PATH(N''), TYPE) AS NVARCHAR(MAX)), 1, 2, '')) + ')'  
                    FROM sys.indexes i WITH(NOLOCK)  
                    WHERE i.[object_id] = @object_id  
                        AND i.is_primary_key = 1), '') + CHAR(13) + ');'  
                    
                SELECT @SQL;        
            ] 
            puts table
            result = ""
            db.fetch(query_template) {|r| 
            
                result += r.values[0]
            }
            result.gsub!("[dbo]", "[loader]")
            directory = "d:\\rubies\\LOADERS"
            file = File.new("d:\rubies\LOADERS\loader.#{table}.sql", 'w+:windows-1251')
            file.puts(result)
            file.close
        end
    end
end

gl = GenerateLoaders.new
gl.Generate
