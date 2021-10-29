require 'benchmark'

def find_substring_slow(s, words)
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

def find_substring(s, words)
    word_map = words.tally
    word_size = words[0].size
    word_count = words.size
  
    memo = {}
    result = []
    start_bound = 0
    end_bound = s.size - word_size * word_count
    while start_bound <= end_bound
        word_count.times do |count|
        substr = s.slice(start_bound + word_size * count, word_size)
        break if word_map[substr].nil?
  
        memo[substr] ||= 0
        memo[substr]  += 1
        break if word_map[substr] < memo[substr]
      end
  
      result << start_bound if word_map == memo
      start_bound += 1
      memo.clear
    end
    return result
  end

s = "bcabbcaabbccacacbabccacaababcbb"
words = ["c","b","a","c","a","a","a","b","c"]
Benchmark.bm do |x|
    x.report do
        pp find_substring s, words
    end
    x.report do
        pp find_substring_slow s, words
    end
end
