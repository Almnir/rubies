require 'open-uri'

open('http://oge.fipi.ru/os/xmodules/qprint/qsearch.php?theme_guid=7FB3C5883E7EAA124B0CA4C6760FCE01&proj_guid=DE0E276E497AB3784C3FC4CC20248DC0') do |file|
    file.each_line { |line| puts line }
end