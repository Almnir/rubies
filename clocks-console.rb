require 'tty-cursor'

class Clocks
	def initialize
		@cursor = TTY::Cursor
		@clock_list = %w[🕛 🕧 🕐 🕜 🕑 🕝 🕒 
		🕞 🕓 🕟 🕔 🕠 🕕 🕡 🕖 
		🕢 🕗 🕣 🕘 🕤 🕙 🕥 🕚 🕦]
        @clocks = @clock_list.dup
	end
	def ⏲
		@clock_list.each do |clock|
			print @cursor.save
			print clock
			print @cursor.restore
			sleep(1)
		end
	end
	def get_next
        a = @clocks.take(1).flatten
        @clocks.rotate!
        print @cursor.save
        print a
        print @cursor.restore
    end
	def gnext
		print "🟪"
	end
end

⏰ = Clocks.new
⏰.⏲

10.times {
	⏰.gnext
	sleep(1)
}