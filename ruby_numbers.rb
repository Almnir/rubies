# (2..40).to_a.product((2..41).to_a).map { |k,v| k**v }.uniq.join(', ')
result = []
columnX = []
columnY = []
pairs = (3..99).to_a.product((3..110).to_a)
pairs.each { |x, y|
    z = (x**y).hash
    unless result.include?(z)
        result << z
        columnX << x
        columnY << y
    end
}

d = ""
columnX.zip(columnY) { |a,b| d += "#{a}; #{b}\n "}
open('my_ruby.out', 'w') do |f|
    # f << "значение : степень\n"
    f << d
end
