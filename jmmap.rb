require "jruby-mmap"

BYTE_SIZE = 2048
FILE_PATH = "mmapfile.dat"

mmap = Mmap::ByteBuffer.new(FILE_PATH, BYTE_SIZE)
mmap.put_bytes("foobar")
mmap.close