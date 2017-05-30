p 'enter string'
str = gets.chomp
p 'enter method name'
method = gets.chomp.to_sym
p str.send(method)