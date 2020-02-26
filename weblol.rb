require 'sinatra'

get '/' do
    "<html><b>OH MY FUCKING DOG!1111</b></html>"
end

get '/gettime' do
    get_time = Time.now.getlocal
    "А сейчас: #{get_time}"
end
