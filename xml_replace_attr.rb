require "rexml/document"
include REXML

BASEDIR = "d:/99/XMLKim"

def processXmlFileLiterature fileName
    xmlfile = File.read(fileName)
    xmldoc = Document.new(xmlfile)
    xmldoc.context[:attribute_quote] = :quote
    count = 0
    XPath.each(xmldoc, "//items/item") do |node| 
        if node.attributes["name"] == "B05"
            node.attributes["name"] = "B07"
            count += 1
        elsif node.attributes["name"] == "B06"
            node.attributes["name"] = "B08"
            count += 1
        elsif node.attributes["name"] == "B07"
            node.attributes["name"] = "B09"
            count += 1
        end
    end
    # xmldoc.write(File.open(fileName, "w"), -1)
    File.open(fileName, "w") do |file|
        xmldoc.write(:output => file, :indent => -1, :transitive => false)
    end
    puts "replaces #{count}"
end
def processXmlFileGeography fileName
    xmlfile = File.read(fileName)
    xmldoc = Document.new(xmlfile)
    xmldoc.context[:attribute_quote] = :quote
    count = 0
    XPath.each(xmldoc, "//items/item") do |node| 
        if node.attributes["name"] == "B22"
            node.attributes["name"] = "B23"
            count += 1
        end
    end
    File.open(fileName, "w") do |file|
        xmldoc.write(:output => file, :indent => -1, :transitive => false)
    end
    puts "replaces #{count}"
end

Dir.glob(BASEDIR + "/**/*.xml") do |file|
    if file.include? "Литература"
        processXmlFileLiterature file
    elsif file.include? "География"
        processXmlFileGeography file
    end
    puts "processed: #{file}"
end