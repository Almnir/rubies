array = []
duplicates_count = 0

File.open("duplicates.txt").each do |line|
    if array.include?(line) then
        puts line
        duplicates_count += 1
    else
        array << line
    end
end
puts "found #{duplicates_count} duplicates" unless duplicates_count == 0