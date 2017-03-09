#идеальный вес
print "Введите Ваше имя: "
name = gets.chomp

print "Введите Ваш рост(в см): "
height = gets.chomp.to_i

if height > 110
  puts "Привет, #{name}! Ваш идеальный вес: #{height - 110}"
else
  puts "Введите рост(в см, > 110)"
end