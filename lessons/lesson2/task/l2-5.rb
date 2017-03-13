#l2-5
#Год високосный, если он делится на четыре без остатка, 
#но если он делится на 100 без остатка, это не високосный год. 
#Однако, если он делится без остатка на 400, это високосный год. 
#Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет.
puts "Введите день"
day = gets.chomp.to_i

puts "Введите месяц"
month = gets.chomp.to_i

puts "Введите год"
year = gets.chomp.to_i

month_array = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

#if day > month_array[month-1] || day < 1 || month > 12 || month <1 || year < 1
if day > 31 || not(month.between?(1,month_array.size))
  puts "Введены некорректные данные"
#иначе будет ошибка определения условия day.between?(1, month_array[month-1])
elsif not(day.between?(1, month_array[month-1])) || year < 1
  puts "Введены некорректные данные"
else
  if (year % 4 == 0) || (year % 400 == 0) && (year % 100 > 0) 
    month_array[1] += 1
  end

  puts month_array[1]

  0.upto(month-2) do |i|
    puts day
    day += month_array[i]
    puts day
  end 

  puts "Введенный день - #{day}-й день #{year} года"
end