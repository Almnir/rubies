array = [1,4,5,2,3,9,8,11,0]
array1 = [1,4,3,2]
array2 = [1,4]

def int_to_range x
    return if x.empty? 
    seq, i = [[x[0]]], 0  
    x.sort.each_cons(2) { |x,y| y-x == 1 ? seq[i] << y : seq[i+=1] = [y] }
    seq.map { |range| range[0]..range[-1] }  
end

int_to_range(array)
# puts int_to_range(array1)
# puts int_to_range(array2)
