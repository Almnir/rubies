require 'nokogiri'
require 'open-uri'
require 'mail'

SUBSCRIPTIONS_CLOSED = "К сожалению, на данный момент все подписки закрыты"

def webget
    # begin
        doc = Nokogiri::HTML(open("http://www.samplesociety.ru/subscriptions"))
        h2 = doc.at_css "h2"
        return h2.content
    #     sleep(1000)
    # end while (h2.content == SUBSCRIPTIONS_CLOSED) || (keyPressed == 'q')
end
def mailer
    mail = Mail.new do
      from     'robot@mailer.com'
      to       'almnir@yandex.ru'
      subject  'robot: webdaemon'
      body     'notification'
    end
    puts mail.to_s
end
def beeps
    3.times { puts 7.chr }
end

def main
    STDOUT.sync = true
    loopStopped = true
    webloop = Thread.new do
        loop do
            Thread.stop if loopStopped
            if webget != SUBSCRIPTIONS_CLOSED
                beeps
                break
            end
            sleep 1000
        end
    end
    keyloop = Thread.new do
        loop do
            print "> "
            response = gets

            case response.strip.downcase
            when "start"
              loopStopped = false
              webloop.wakeup
            when "stop"
              loopStopped = true
            when "exit"
              webloop.terminate!
              Thread.exit
            end
        end
    end
    webloop.join
    keyloop.join
end

def read_char
  begin
    # save previous state of stty
    old_state = `stty -g`
    # disable echoing and enable raw (not having to press enter)
    system "stty raw -echo"
    c = STDIN.getc.chr
    # gather next two characters of special keys
    if(c=="\e")
      extra_thread = Thread.new{
        c = c + STDIN.getc.chr
        c = c + STDIN.getc.chr
      }
      # wait just long enough for special keys to get swallowed
      extra_thread.join(0.00001)
      # kill thread so not-so-long special keys don't wait on getc
      extra_thread.kill
    end
  rescue => ex
    puts "#{ex.class}: #{ex.message}"
    puts ex.backtrace
  ensure
    # restore previous state of stty
    system "stty #{old_state}"
  end
  return c
end

main
