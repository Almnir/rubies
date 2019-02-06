require 'matrix'

testMatrix = Matrix.build(500, 500) { |row, col| 100+rand%1000 }
testMatrix.collect {|x| (x/(2+rand%10)).round }
