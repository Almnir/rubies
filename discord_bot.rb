require 'discordrb'

file_data = File.readlines("d:\\rubies\\raid_champions.txt").map! {|x| x.delete("\n")}
hash_data = Hash.new
file_data.each do |x|
    hash_data[x] = "https://ayumilove.net/raid-shadow-legends-" + 
                    x.split("\t")[1].downcase.gsub(/\s/,"-") +
                    "-skill-mastery-equip-guide/"
end

bot = Discordrb::Commands::CommandBot.new token: 'NzY1OTAxMzc2Mzk5MDgxNTEz.X4bjPQ.NzN23ce7boCqHiPxm369wrEybvI', client_id: 765901376399081513, prefix: '~'

bot.command(:raid) do |event|
    champion = event.message.content.split(' ')[1]
    link = ""
    hash_data.each do |key,value|
        if key.split.any? {|x| x.downcase.start_with?(champion.downcase)}
            link += key.split("\t").join(" или ") + ": "
            link += value + "\n"
        end
    end
    unless link.empty?
        puts "respond: #{link}"
        event.respond link
    else
        event.respond "Извините, не знаю о ком вы!"
    end
end

bot.run