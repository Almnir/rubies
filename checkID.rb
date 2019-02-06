require "rexml/document"
require 'colorize'

files = Dir.glob("**/*.fcrp")

file_id = {}
found_duplicates = {}

files.each do |file_name|
    file = File.new(file_name, "r")
    doc = REXML::Document.new(file)
    id = doc.elements["Report/ID"].text
    found = file_id.select { |k,v| v == id }
    if not found.empty?
        found_duplicates[id] = found.keys.join(', ').to_s + '===' + file_name
    end
    file_id[file_name] = id
    file.close()
end

found_duplicates.each do |key, value|
    puts "DUPLICATE #{key}, #{value}".colorize(:color => :white, :background => :red)
end
