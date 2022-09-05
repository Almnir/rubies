def move_zeroes(nums)
    zcount = nums.count {|x| x == 0 }
    nums.delete(0)
    nums.push(Array.new(zcount,0)).flatten!
end
def move_zeroes(nums)
    pos = 0
    for i in (0...nums.length) do
        el = nums[i]
        unless el == 0
            nums[pos], nums[i] = nums[i], nums[pos]
            pos += 1
        end
    end
end

nums = [0,1,0,3,12]
move_zeroes(nums)
pp nums
nums = [0]
move_zeroes(nums)
# puts
pp nums
nums = [1]
move_zeroes(nums)
# puts
pp nums
nums = [0,0,1]
move_zeroes(nums)
# puts
pp nums
