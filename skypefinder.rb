require 'sqlite3'
SQLite3::Database.new( 'd:\main.db' ) do |db|
  db.execute( "SELECT body_xml FROM Messages where chatname = '19:317cba2df4ea4b9b80c161c85435472c@thread.skype' and body_xml like '%завтра%'" ) do |row|
    puts row
  end
end
