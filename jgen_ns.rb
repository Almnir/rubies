require "rubygems"
require "java"
# require "sequel"
# require 'd:/rubies/sqljdbc42.jar'
require 'd:/rubies/mssql-jdbc-11.2.0.jre18.jar'

Java::com.microsoft.sqlserver.jdbc.SQLServerDriver

# DB = Sequel.connect(
#   	:adapter => "jdbc",
# 		:url => "jdbc:sqlserver://10.0.18.110;database=erbd_gia_reg_18_70;user=sa;password=Qwerty123"
# 	)

# dataset = DB['select * from rbd_Areas']

# dataset.each do |row|
#     p row
# end

url = "jdbc:sqlserver://10.0.18.3:1433;DatabaseName=erbd_gia_reg_22_90;integratedSecurity=false;"
conn = java.sql.DriverManager.get_connection(url, 'ra', 'Njkmrjcdjb')

statement = conn.create_statement

q = 'SELECT * FROM rbd_Participants'
rs = statement.execute_query(q)

while (rs.next) do
  puts rs.getObject('Surname')
end

statement.close
conn.close