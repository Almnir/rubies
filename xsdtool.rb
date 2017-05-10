Dir.glob('*.xsd') do |f|
    puts f
    # system "xsd /classes #{f}"
    system "xsd /nologo /c /eld #{f}"
end