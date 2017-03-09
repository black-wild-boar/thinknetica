#trigon-rectangular
print "Введите первую сторону треугольника: "
a = gets.chomp.to_f

print "Введите вторую сторону треугольника: "
b = gets.chomp.to_f

print "Введите третью сторону треугольника: "
c = gets.chomp.to_f

trigon_array = [a,b,c]

gipotenuse = trigon_array.max

trigon_array.delete(gipotenuse)

if trigon_array.count == 0
  puts "Все 3 стороны равны. Треугольник равнобедренный и равносторонний, но не прямоугольный"
end

if trigon_array.count ==1
  puts "Такое невозможно. Гипотенуза не может быть равна катету"
else
  if trigon_array[0] == trigon_array[1]
    puts "Треугольник равнобедренный"
  else
    puts "Треугольник не равнобедренный"
  end
  if gipotenuse ** 2 == trigon_array[0] ** 2 + trigon_array[1] ** 2
    puts "Треугольник прямоугольный"
  else
    puts "Треугольник не прямоугольный"
  end
end
