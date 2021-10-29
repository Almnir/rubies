def fun x
    x.map {|y| (x-[y]).inject(:*)}
end

puts (fun [1,4,3]).inspect