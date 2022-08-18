require 'fileutils'

rootDir = 'd:/Files/2020-2021'
copyDir = 'd:/!/111'

files = %w[
9021240-P2----20210409-(EGE_21_spring).b2p
9020340-P2----20210409-(EGE_21_spring).b2p
9020342-03-0411-0001--20210412-(EGE_21_spring).b2p
]
counter = 0
files.each do |file|
    sourcePath = Dir.glob("#{rootDir}/**/#{file}")
    if sourcePath.empty?
        puts "NOT FOUND!!!!" 
    else
        puts sourcePath
        # FileUtils.cp(sourcePath, copyDir)
        # FileUtils.rm sourcePath
        counter += 1
    end
    puts "#{counter} processed!"
end