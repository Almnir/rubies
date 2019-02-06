# require 'rufus-scheduler'
# # require 'sequel'
# require 'tiny_tds'
# require "rexml/document"

proper_string = ""

require 'sequel'
require 'tiny_tds'

db_connection_params = {
  :adapter => 'tinytds',
  :host => '10.0.18.3', # IP or hostname
  :port => '1433', # Required when using other that 1433 (default)
  :database => 'ERBD_EGE_MAIN_17_Fresh_20170424',
  :user => 'ra',
  :password => 'Njkmrjcdjb'
}

client = Sequel.connect(db_connection_params)

examdate = Time.now.strftime('%Y.%m.%d')
sqlquery = client.escape("SELECT r.REGION AS '@code', r.RegionName AS '@name',
           (SELECT DISTINCT ev.ZoneCode AS '@zone', s.SubjectCode AS '@code',
                   s.SubjectName AS '@name', e.ExamDate AS '@date', ev.VariantCode AS '@variant'
              FROM scp_ComplectVariants AS cv
              JOIN (SELECT REGION, ComplectID
                      FROM res_Complects
                     UNION ALL
                    SELECT REGION, SubcomplectID AS ComplectID
                      FROM res_SubComplects) AS c
                ON c.ComplectID = cv.ComplectFK
              JOIN sc_ExamVariants AS ev
                ON ev.ExamVariantID = cv.ExamVariantFK
              JOIN sc_Exams AS e
                ON e.ExamID = ev.ExamFK
              JOIN sc_Subjects AS s
                ON s.SubjectID = e.SubjectFK
             WHERE c.REGION = r.REGION AND
                   e.ExamDate = #{examdate}
             ORDER BY e.ExamDate, s.SubjectCode
               FOR XML PATH('exam'), TYPE) AS exams
      FROM rbdc_Regions AS r
       FOR XML PATH('region'), ROOT('regions_variants')
")

dataset = sqlquery.execute.all

dataset.map do |h| 
      proper_string += h.values.join.to_s 
end
puts proper_string


#   client = TinyTds::Client.new username: 'ra', password: 'Njkmrjcdjb', host: '10.0.18.3', port: 1433, database: 'ERBD_EGE_MAIN_17_Fresh_20170424', azure:false
#   examdate = Time.now.strftime('%Y.%m.%d')

#   sqlquery = client.escape("SELECT r.REGION AS '@code', r.RegionName AS '@name',
#              (SELECT DISTINCT ev.ZoneCode AS '@zone', s.SubjectCode AS '@code',
#                      s.SubjectName AS '@name', e.ExamDate AS '@date', ev.VariantCode AS '@variant'
#                 FROM scp_ComplectVariants AS cv
#                 JOIN (SELECT REGION, ComplectID
#                         FROM res_Complects
#                        UNION ALL
#                       SELECT REGION, SubcomplectID AS ComplectID
#                         FROM res_SubComplects) AS c
#                   ON c.ComplectID = cv.ComplectFK
#                 JOIN sc_ExamVariants AS ev
#                   ON ev.ExamVariantID = cv.ExamVariantFK
#                 JOIN sc_Exams AS e
#                   ON e.ExamID = ev.ExamFK
#                 JOIN sc_Subjects AS s
#                   ON s.SubjectID = e.SubjectFK
#                WHERE c.REGION = r.REGION AND
#                      e.ExamDate = #{examdate}
#                ORDER BY e.ExamDate, s.SubjectCode
#                  FOR XML PATH('exam'), TYPE) AS exams
#         FROM rbdc_Regions AS r
#          FOR XML PATH('region'), ROOT('regions_variants')
#   ")
#   result = client.execute(sqlquery)


#   result.map do |h| 
#       proper_string += h.values.join.to_s 
#   end
#   puts proper_string

# rescue TinyTds::Error => e
#   p e.message, e.backtrace
# end
