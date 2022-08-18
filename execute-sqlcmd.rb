Dir.glob("INSERTS/**/*.sql") do |x| 
    puts x
    %x[sqlcmd -S"10.0.18.3" -d"esrp_prod" -U"ra" -P"Njkmrjcdjb" -t0 -i "d:\\rubies\\INSERTS\\#{x.split('/')[1]}"]
    sleep(10)
end