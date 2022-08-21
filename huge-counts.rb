file_data = File.read("e:/huge.txt")
file_data.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')
File.open("e:/huge_out.txt", "a") do |file|
    file_data.split.tally.sort_by {|_,v| -v}.to_h.each do |k,v|
        file << "#{v.to_s} #{k}\n"
    end
end
