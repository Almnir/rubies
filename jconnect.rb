require 'active_record'
require 'activerecord-jdbc-adapter'
require "java"
# require "sequel"
require 'd:/rubies/sqljdbc42.jar'
# require 'd:/rubies/mssql-jdbc-11.2.0.jre18.jar'

Java::com.microsoft.sqlserver.jdbc.SQLServerDriver


ActiveRecord::Base.pluralize_table_names = false
ActiveRecord::Base.establish_connection(
  :adapter => "sqlserver",
  :username => 'ra',
  :password => 'Njkmrjcdjb',
  :host => "10.0.18.3",
  :database => "erbd_gia_reg_22_89",
  :url => "jdbc:sqlserver://10.0.18.3:1433;DatabaseName=erbd_gia_reg_22_89;integratedSecurity=false;encrypt=false;trustServerCertificate=true;"
)

@connection = ActiveRecord::Base.connection

# puts @connection

q = 'SELECT * FROM dbo.rbd_Participants'
rs = @connection.exec_query(q)

rs.each { |x|
  p x["Surname"]
}

@connection.close