require 'rubygems'
require 'rufus-scheduler'
require 'sequel'
require 'tiny_tds'
require "rexml/document"

exit if defined? Ocra

db_connection_params = {
  :adapter => 'tinytds',
  :host => '10.0.2.2', 
  :port => '1433',
  :database => 'ERBD_GIA_MAIN_18',
  :user => 'ra',
  :password => 'Njkmrjcdjb',
  :timeout => 1000
}

ENV['TZ'] = 'Europe/Moscow'

scheduler = Rufus::Scheduler.new

scheduler.every '10s' do
    puts 'Begin exporting...'

    proper_string = ""

    Sequel.connect(db_connection_params) do |db|

        begin

            examdate = Time.now.strftime('%Y.%m.%d')        
            res = db["
                SELECT r.REGION AS '@code', r.RegionName AS '@name',
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
                           e.ExamDate = ?
                     --and e.WaveCode = 2
                     ORDER BY e.ExamDate, s.SubjectCode
                       FOR XML PATH('exam'), TYPE) AS exams
              FROM rbdc_Regions AS r
               FOR XML PATH('region'), ROOT('regions_variants')
               ", examdate]

            res.map do |h| 
                proper_string += h.values.join.to_s 
            end

        rescue Sequel::Error => e
          p e.message, e.backtrace
        end
    end
    # Форматируем красиво
    doc = REXML::Document.new(proper_string)
    formatter = REXML::Formatters::Pretty.new

    formatted_string = ""
    formatter.write(doc, formatted_string)

    # Вставляем заголовок
    formatted_string.prepend('<?xml version="1.0" encoding="windows-1251"?>')

    # Записываем в файл
    File.open('c:\variant_base.xml', 'w:windows-1251') {|f| f.write(formatted_string) }

    puts 'End exporting...'

end

# Запуск шедулера расписания
scheduler.join
