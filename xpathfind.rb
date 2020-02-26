require 'rexml/document'
include REXML

xmlfile1 = File.new('d:\SCREEEENSHOOOTS\rbd_StationWorkerOnStation.xml')
xmldoc1 = Document.new(xmlfile1)

hashh = {}

xmldoc1.elements.each("ns1:GIADBSet/ns1:rbd_StationWorkerOnStation") do |element|
    # если есть ключ
    if hashh.has_key?(element.elements["ns1:StationId"].text)
        # если элемент соответствует текущему
        if hashh[element.elements["ns1:StationId"].text] == element.elements["ns1:StationWorkerId"].text
            puts "Повтор! "
            puts "StationId: #{element.elements["ns1:StationId"].text}"
            puts "StationWorkerId: #{element.elements["ns1:StationWorkerId"].text}"
        else
            hashh[element.elements["ns1:StationId"].text] = element.elements["ns1:StationWorkerId"].text
        end
    else
        hashh[element.elements["ns1:StationId"].text] = element.elements["ns1:StationWorkerId"].text
    end
end