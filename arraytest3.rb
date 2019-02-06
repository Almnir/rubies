require 'matrix'

threads = []
matrix = []

25.times do |i|
    threads[i] = Thread.new {
        matrix[i] = Matrix.build(1000,1000) { |row, col| 100+rand%1000 }
        matrix[i].collect {|x| (x/(2+rand%10)).round }
    }
end

threads.each { |t| t.join }