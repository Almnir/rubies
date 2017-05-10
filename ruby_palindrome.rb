# [12:54:35] Никита: Задача 1

# Если мы возьмем 47, перевернем его и сложим, получится число 121 — палиндром. 

# Если взять 349 и проделать над ним эту операцию три раза, то тоже получится палиндром: 
# 349 + 943 = 1292
# 1292 + 2921 = 4213
# 4213 + 3124 = 7337

# Найдите количество положительных натуральных чисел меньших 12814 таких, что из них нельзя получить палиндром за 50 или менее применений описанной операции.
# [12:55:06] Никита:  что-то у меня аж 12468 вышло

def palindrome
    number = 0
    count = 0
    loop do
        count += 1 if palin(number)
        number += 1
        break if number > 12814
    end
    return count
end

def palin x
    count = 1
    flag = true
    loop do 
        a = reversed(x)
        if a.to_s.reverse == a.to_s
            flag = false
            break
        end
        break if count > 50 
        count += 1
        x = a
    end
    return flag
end

def reversed x
    x.to_s.reverse.to_i + x
end

puts palindrome
# puts palin(19)
# puts palin(349)
# puts palin(34)
# puts palin(17)