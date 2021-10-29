filedata = File.read('d:\NSISScripts\archivetool1.nsi').force_encoding("cp1251").encode("cp1251", undef: :replace)
File.open('d:\NSISScripts\archivetool_new.nsi', 'w:cp1251') do |file|
    file.write filedata
end