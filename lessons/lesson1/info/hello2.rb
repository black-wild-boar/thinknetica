puts "Whats is your name?"
user_name = gets.chomp

puts "Напиши свой год рождения"
user_year_born = gets.chomp

puts "Привет, #{user_name}! Тебе примерно #{Time.now.year - user_year_born.to_i} года."
