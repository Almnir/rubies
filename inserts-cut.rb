
def chunker f_in, out_pref, chunksize = 2000
    fh_out = File.open("INSERTS/#{out_pref}.sql","w")
    slice_counter = 0
    fileindex = 0
    lines = ""
    IO.foreach("inserts.sql").each do |line|
        lines += line
        if line == "                ); \n"
            if slice_counter > chunksize
                fileindex += 1
                fh_out.close
                fh_out = File.open("INSERTS/#{out_pref}_#{fileindex}.sql","w")
                slice_counter = 0
            end
            lines.encode!("Windows-1251", invalid: :replace, undef: :replace)
            fh_out << lines
            slice_counter += 1
            lines = ""
        end
    end
    fh_out.close unless fh_out.closed?
end

chunker "inserts.sql", "insert"