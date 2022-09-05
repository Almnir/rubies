require 'watir'

browser = Watir::Browser.new

browser.goto 'http://oge.fipi.ru/os/xmodules/qprint/index.php?proj=2F5EE3B12FE2A0EA40B06BF61A015416'
browser.link(text: 'Фонетика').click

# puts browser.title
# puts browser.p(class: "normaltext").text
browser.table.trs.each do |tr|
    p tr.p.text
  end

# browser.wait(5000)
# => 'Guides – Watir Project'
browser.close