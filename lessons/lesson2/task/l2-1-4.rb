#l2.1-4

#1
month_hash = { "January" => 31, "February" => 28, "March" => 31, "April" => 30, 
              "May" => 31, "June" => 30, "July" => 31, "August" => 31, "September" => 30,
              "October" => 31, "November" => 30, "December" => 31 }

puts "Месяцы, у которых количество дней > 30:"

month_hash.each { |key, value| puts "#{key} is #{value}" if value == 30 }

#2
numbers = []

(10..100).step(5) {|i| numbers << i}

puts "Массив чисел от 10 до 100 с шагом 5:"
puts numbers

#3
fibonacci_array = [0,1]

while (fibonacci_array[-1] + fibonacci_array[-2]) < 100 do 
    fibonacci_array << fibonacci_array[-1] + fibonacci_array[-2]
end

puts "Fibonacci sequence with numbers < 100: " + fibonacci_array.to_s

#4
vowels = %w(а о э и у ы е ё ю я)

#abc = ('а'..'я').to_a #косяк метода. Считается, что буквы ё нет => 32 буквы )))
#abc.each {|i| puts "#{i} #{abc.index(i)+1}" }

abc = ['а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я']

vowels_with_index = {}

#vowels.each { |value| vowels_with_index[value] = abc.index(value) + 1 if abc.include?(value) }

abc.each_with_index do |value, index| 
  if vowels.include?(value)
    vowels_with_index[value] = index+1
  end
end

puts "{Хэш гласных букв с порядковым номером: #{vowels_with_index}"
