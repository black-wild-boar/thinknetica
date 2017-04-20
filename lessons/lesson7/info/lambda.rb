
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

class Flyer
  attr_reader :name, :email, :miles_flown

@fluers = []

  def initialize(name, email, miles_flown)
    @name = name
    @email = email
    @miles_flown = miles_flown
  end

  def to_s
    "#{name} (#{email}): #{miles_flown}"
  end

  def self.all
    @flyers
  end

  def create_new(times)
    puts times
    1.upto(times) do |count|
      puts self.class.new("Flyer #{count} ","(flyer#{count}): ",count*1000)
    end
  end
end

