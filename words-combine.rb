# puts ARGV[0]
# puts ARGV[1]

# i, j = 1, 0
# while i <= ARGV[0].length && i <= ARGV[1].length
#     if ARGV[0][-i..] == ARGV[1][0...i] then
#         res = ARGV[0]+ARGV[1][i..]
#         break
#     end
#     i+=1
# end
# if j != 0 then
    
#     puts res
# end
a = ARGV[0]
b = ARGV[1]
# puts a[...a.rindex(a.chars.intersection(b.chars).join)]+b[a.rindex(a.chars.intersection(b.chars).join)..]
# puts a[...a.rindex(a.chars.intersection(b.chars).join)]
# puts b[b.rindex(a.chars.intersection(b.chars).join)..]
puts a.rpartition(a.chars.intersection(b.chars).join).difference(b.rpartition(a.chars.intersection(b.chars).join)).join
# puts res