require 'gdbm'

gdbm = GDBM.new("mydb.db")
# gdbm["ananas"]    = "3"
# gdbm["banana"]    = "8"
# gdbm["cranberry"] = "4909"

gdbm.each_pair do |key, value|
  print "#{key}: #{value}\n"
end

gdbm.close
