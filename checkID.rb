require "rexml/document"
require 'colorize'

files = Dir.glob("**/*.fcrp")

file_id = {}
ids = []

files.each do |file_name|
    file = File.new(file_name, "r")
    doc = REXML::Document.new(file)
    id = doc.elements["Report/ID"].text
    file_id[file_name] = id
    ids << id
    file.close()
end

non_uniq = ids.select { |x| ids.count(x) > 1 } .uniq

file_id.each do |key, value|
    if non_uniq.include?(value)
        puts "DUPLICATE #{key}, #{value}".colorize(:color => :white, :background => :red)
    else
        puts "#{key}, #{value}".colorize(:color => :white, :background => :green)
    end
end

