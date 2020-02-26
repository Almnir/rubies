require 'date'
require 'net/http'

# STARTER = 'd:\Projects\m_use\binaries\Release\AnyCPU\DDWorker\DDWorkerConsole.exe'
STARTER = File.join("D:", "Projects", "m_use", "binaries", "Release", "AnyCPU", "DDWorker", "DDWorkerConsole.exe")

Date.new(2019, 12, 01).upto(Date.today) do |date|
    # params = {date: '#{date.to_s}', content_type: :json}
    # response = RestClient.get 'http://mcko.ru/api/diagnostic_requests_export', params
    uri = URI('https://www1.mcko.ru/api/diagnostic_requests_export')
    params = { 'date' =>  "#{date.to_s}"}
    uri.query = URI.encode_www_form(params)
    uri.scheme = 
    puts uri
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    res = http.get(uri.request_uri)
    # не работает вот так из-за https
    # res = Net::HTTP.get_response(uri)
    if res.is_a?(Net::HTTPSuccess) && !res.body.empty? && res.body != '[]'
        puts "#{STARTER} import -m0 -e -d\"#{date.to_s}\""
        pid = Process.spawn("#{STARTER} import -m0 -e -d\"#{date.to_s}\"")
        Process.wait pid
    else
        puts res.code
        puts res.message
    end
end