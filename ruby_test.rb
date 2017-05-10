a = []
File.read('myfile_ruby.out').split(',').each { |x| a << x.to_f }
puts a.size
b = []
File.read('test.data').split(',').each { |x| b << x.to_f }
puts b.size
c = b - a 
c.each { |x|
    puts "#{x}"
}