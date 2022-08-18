require 'csv'
require 'date'

def parseSubject x
    str = ""
    x.split("\n").each do |y|
        if y.start_with?("Общ")
            str += "12,"
        end
        if y.start_with?("Русск")
            str += "1,"
        end
        if y.start_with?("Матема")
            str += "2,"
        end
        if y.start_with?("Геог")
            str += "8,"
        end
        if y.start_with?("Инфор")
            str += "5,"
        end
        if y.start_with?("Биол")
            str += "6,"
        end
        if y.start_with?("Истор")
            str += "7,"
        end
        if y.start_with?("Физи")
            str += "3,"
        end
    end
    str[-1] = "" unless str.empty?
    return str
end

def parseDates dates
    str = ""
    dates.split("\n").each do |date|
        str += "'" + Date.parse(date).strftime("%Y.%m.%d") + "',"
    end
    str[-1] = ""
    return str
end

csv_data = File.read("d:/SCREEEENSHOOOTS/26/Списки участников для ошибочной отмены двоек.csv").encode("utf-8", undef: :replace).force_encoding("cp1251").encode("utf-8", undef: :replace)

result_queries = ""
counter = 0
CSV.parse(csv_data, encoding:'utf-8', headers: true, col_sep: ';', liberal_parsing: true).each do |x|
    template = %Q[
        with 
        wcc (HumanTestID) as (
            select distinct t.HumanTestID
            from dbo.res_HumanTests as t
            join dbo.rbd_Participants as p
              on p.ParticipantID = t.ParticipantFK
            where 
            p.ParticipantID = '#{x["ID участника"]}'
            and t.SubjectCode in (#{parseSubject(x["Предмет"])})
            and t.ExamDate in (#{parseDates(x["Дата предмета"])})
        )
        UPDATE dbo.res_HumanTests
        SET ProcessCondition = 6
        FROM dbo.res_HumanTests AS ht
        JOIN wcc ON ht.HumanTestID = wcc.HumanTestID;
    ]
    result_queries += template
    counter+=1
end

File.open('updatesCancellations.txt', 'w:windows-1251') do |file|
    file.write result_queries
end

puts "Processed: #{counter}"
