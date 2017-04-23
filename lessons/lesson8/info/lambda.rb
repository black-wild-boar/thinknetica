
# 5.times do |count|
# puts "#{count} situp"
# puts "#{count} pushup"
# puts "#{count} chinup"
# end

# 1.upto(5) do |count|
# puts "#{count} situp"
# puts "#{count} pushup"
# puts "#{count} chinup"
# end

# class Flyer
#   attr_reader :name, :email, :miles_flown

# @flyers = []

#   def initialize(name, email, miles_flown)
#     @name = name
#     @email = email
#     @miles_flown = miles_flown
#   end

#   def to_s
#     "#{name} (#{email}): #{miles_flown}"
#   end

#   def self.all
#     @flyers
#   end

# 1.upto(5) { |count| @flyers << Flyer.new("Flyer#{count}","flyer#{count}@example.com", count*1000) }
# puts "upto 5"  
# puts @flyers  

# @flyers = []
# 1.step(9,2) { |count| @flyers << Flyer.new("Flyer#{count}","flyer#{count}@example.com", count*1000) }
# puts "step 2 to 9"
# puts @flyers  
# end

def call_block  
  puts 'Start of method'  
  # you can call the block using the yield keyword  
  yield  
  yield  
  puts 'End of method'  
end  
# Code blocks may appear only in the source adjacent to a method call  
call_block {puts 'In the block'}  

# You can provide parameters to the call to yield:  
# these will be passed to the block  
def call_block  
  yield('hello', 99)  
end  
call_block {|str, num| puts str + ' ' + num.to_s}  

def try  
  if block_given?  
    yield  
  else  
    puts "no block"  
  end  
end  
try # => "no block"  
try { puts "hello" } # => "hello"  
try do puts "hello" end # => "hello"  

x = 10  
5.times do |x|  
  puts "x inside the block: #{x}"  
end  
  
puts "x outside the block: #{x}"  

x = 10  
5.times do |y; x|  
  x = y  
  puts "x inside the block: #{x}"  
end  
puts "x outside the block: #{x}"  
