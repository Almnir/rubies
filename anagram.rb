require 'open-uri'
require 'pp'

anagram = Hash.new {|hash, key| hash[key] = []} # map sorted chars to anagrams
 
URI.open('http://wiki.puzzlers.org/pub/wordlists/unixdict.txt') do |f|
  words = f.read.split
  for word in words
    anagram[word.split('').sort] << word
  end
end

# anagram = anagram.take(200)

count = anagram.values.map {|ana| ana.length}.max
anagram.each_value do |ana|
  if ana.length >= count
    p ana
  end
end
