require 'win32ole'

begin
    outlook = WIN32OLE.new('Outlook.Application')
rescue Exception => e
    alert("Ошибка создания объекта Outlook!")
    return
end

# основная коллекция фио-телефон
collection = {}

mapi = outlook.GetNameSpace('MAPI')
address_list = mapi.Session.AddressLists('All Users')
address_list.AddressEntries.each do |address|
        exuser = address.GetExchangeUser
        if (exuser != nil)
            phone = exuser.BusinessTelephoneNumber
            name = address.Name
            if (/\w{2,}+/ !~ name)
                puts address.Name
                puts phone
                collection.store(address.Name, phone)
            end
        end
end

# collection.each do |key, value|
#     puts "#{key}  #{value}"
# end
# puts "Total: #{collection.length}"
# begin
#     excel = WIN32OLE.new('Excel.Application')
# rescue Exception => e
#     alert("Ошибка создания объекта Excel!")
#     return
# end
# workbook = excel.Workbooks.Add()
# worksheet = workbook.Worksheets(1)
# worksheet.Range("A1:B1").value = ["ФИО", "Телефон"]

# i = 1
# collection.each do |key, val|
#     worksheet.Range("A#{i+1}").value = key
#     worksheet.Range("B#{i+1}").value = val
#     i+=1
# end

# workbook.SaveAs('d:\myworkbook.xlsx')
# workbook.Close
# excel.Quit()
