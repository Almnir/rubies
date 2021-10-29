require 'rexml/document'
include REXML

def processXmlFile fileName
    File.open(fileName, "rw") do |file|
        xmlfile = file.read
        xmldoc = Document.new(xmlfile)
        xmldoc.root.attributes["condition"] = "19"
        xmldoc.write(file)
    end
end

rootDir = 'd:\SCREEEENSHOOOTS\xml собеседование 11.03.20'

path = File.join(rootDir, '\*.xml')

p path.replace('\\', '/')

files = Dir[rootDir]
puts files.to_s