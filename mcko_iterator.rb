require 'Date'
require 'net/http'
require 'json'

json = []

allcounter = 0
Date.new(2018, 12, 01).upto(Date.new(2018, 12, 13)) do |date|
    # params = {date: '#{date.to_s}', content_type: :json}
    # response = RestClient.get 'http://mcko.ru/api/diagnostic_requests_export', params
    uri = URI('http://mcko.ru/api/diagnostic_requests_export')
    params = { 'date' =>  "#{date.to_s}"}
    uri.query = URI.encode_www_form(params)
    puts uri.query
    puts uri.to_s
    res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess) && !res.body.empty? && res.body != '[]'
        result = res.body.force_encoding("utf-8")
        # file << res.body
        json << result
        pcounter = 0
        JSON.parse(result).each do |child1|
            child1['auditorium'].each do |child2|
                child2['participants'].each do |child3|
                    pcounter += 1
                    allcounter += 1
                    # puts "Дата выгрузки: #{date.to_s} Дата экзамена: #{child3['exam_date']}"
                end
            end
        end        
    puts "На дату #{date.to_s} участников выгружено : #{pcounter}"
# JSON.parse(result).each do |key, value|
#             puts "#{key} - #{value}"
#             if (key == 'exam_date')
#                 puts "Дата выгрузки: #{date} Дата экзамена: #{value}"
#             end
#         end
    end
end
puts "Всего участников выгружено : #{allcounter}"


File.open('d:\rubies\json_mcko_today.txt', 'w:windows-1251') do |file|
    file.write json.to_json
end