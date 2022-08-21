require 'async'
require 'net/http'
require 'uri'

LINKS = [
  'https://bigbinary.com',
  'https://basecamp.com'
]
arr = ""

Async do
  LINKS.each do |link|
    Async do
      arr += Net::HTTP.get(URI(link))
    end
  end
end
puts arr