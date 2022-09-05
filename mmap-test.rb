require 'win32/mmap'
include Win32

@mmap = MMap.new(:name => 'test', :size => 100)

# 1.upto(10) do |x|
    # puts x
    @mmap.write_string("1")
    @mmap.write_string("2")
    @mmap.write_string("3")
# end

# 1.upto(10) do |x|
puts @mmap.read_string(30)
# puts @mmap.read_string(10)
# end

@mmap.close
