require_relative 'main_railway.rb'

def intro(key)
  puts "\n"
  puts 'Рады приветствовать Вас на нашей трешовой станции!'
  puts "\n"
  puts 'Управление станциями. Жми 1'
  puts 'Управление маршрутами. Жми 2'
  puts 'Управление поездами. Жми 3'
  puts 'Для выхода введи exit'
  key = gets.chomp
  mainmenu
end

def 