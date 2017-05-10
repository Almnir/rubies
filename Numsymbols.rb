keys = [:q, :r, :v, :w, :z]
all = {}
count = 0
[0,1,2,3,4,5,6,7,8,9].permutation(5).to_a.each { |arr|
    keys.zip(arr) { |a,b| all[a] = b }
    # rqr + zvv = rqvw
    expression = all[:r]*all[:q]*all[:r] + all[:z]*all[:v]*all[:v]
    equation = all[:r]*all[:q]*all[:v]*all[:w]
    if (equation == expression)
        count += 1
    end
}
puts count