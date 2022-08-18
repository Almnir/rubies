require 'sequel'
require 'tiny_tds'

db_connection_params = {
  :host => '10.0.18.3',
  :database => 'esrp_prod',
  :user => 'ra',
  :password => 'Njkmrjcdjb'
}

DB = Sequel.tinytds(db_connection_params)

table_name = "SCHOOL_KINDS"
# sl = Sequel::qualify(:eiis, table_name.to_sym)
tbl = DB.from{eiis[table_name.to_sym]}

dataset = tbl.take(20)

dataset.each do |row|
  puts row.to_s
end

DB.disconnect