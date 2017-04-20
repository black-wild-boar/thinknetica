# begin
#   puts 'Before exception'
#   Math.sqrt(-1)
# # обработчик исключения
# rescue StandardError => e
#   puts "Exceptions: #{e.message}"
#   puts e.backtrace.inspect
# # выброс исключения (всё, что после raise - не выполняется)
# raise
# rescue NoMemoryError => e
#   puts "No memory!"
# end

# puts "After exception"

# def method_with_error
# #...
#   raise ArgumentError, "Oh no!"
# end

# begin
#   method_with_error
# rescue RuntimeError => e
#   puts e.inspect
# end

# puts "After exception"

# def sqrt(value)
#   sqrt = Math.sqrt(value)
#   puts sqrt
# rescue StandardError
#   puts "Неверное значение"
# end

# sqrt(-1)

def connect_to_wikipedia
  #...
  raise "Connection error"
end

attempt = 0

begin
  connect_to_wikipedia
rescue RuntimeError
#rescue NoMemoryError
  attempt += 1
  puts "Check your internet connections"
  #возвращает в начало блока begin
  retry if attempt < 3
  puts "After Check your internet connections"
#код в этом блоке ensure выполнится в любом случае
ensure
  puts "There was #{attempt} attempts"
end
