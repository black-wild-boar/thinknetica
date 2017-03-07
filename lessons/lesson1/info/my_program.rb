# class Sample
#   def hello
#     puts "Hello, World!"
#   end
# end

# s = Sample.new
# s.hello

class Water
def water_status(minutes)
  if minutes < 7
    puts "The water is not boiling yet."
  elsif minutes == 7
    puts "It's just barely boiling"
  elsif minutes == 8
    puts "It's boiling!"
  else
    puts "Hot! Hot! Hot!"
  end
end
end

bw = Water.new
bw.water_status(5)