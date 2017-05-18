p 'Enter string'
str = gets.chomp
p 'Enter method'
method = gets.chomp.to_sym
puts str.send(method)