def find_substring(s, words)
    out_array = Array.new
    words.permutation.each do |word|
        concatenated = word.join
        concatenated_reverse = word.reverse.join
        sz = concatenated.size
        sz_r = concatenated_reverse.size
        out_array << [(0..s.size-sz).select { |i| s[i,sz] == concatenated }, (0..s.size-sz_r).select { |i| s[i,sz_r] == concatenated_reverse }]
    end
    returned = out_array.flatten!.compact.uniq!
    returned == nil ? [] : returned
end
# s = "barfoofoobarthefoobarman"
# words = ["bar","foo","the"]

# s = "barfoothefoobarman"
# words = ["foo","bar"]

# s = "wordgoodgoodgoodbestword"
# words = ["word","good","best","word"]

# s = "foobarfoobar"
# words = ["foo","bar"]

s= "bcabbcaabbccacacbabccacaababcbb"
words = ["c","b","a","c","a","a","a","b","c"]

pp find_substring(s,words)