class Carriage
  attr_reader :number

  @carriages = {}

  def initialize(number)
    @number = number
  end

protected
  attr_writer :number

#должен существовать общий реестр вагонов
  def self.carriage_add(train_type, carriage_name)
#    if @carriages.empty?
#      puts "empty"
#      @carriages[carriage_name.class.name.to_sym] = []
#      @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#    elsif !@carriages.include?(carriage_name.class.name.to_sym) 
#      puts "empty not"
#      @carriages[carriage_name.class.name.to_sym] = []
#      @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#    else
#      puts "empty not yes"
#      if !@carriages[carriage_name.class.name.to_sym].include?(carriage_name.number)
#        @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#      else
#        puts "Номер вагона уже есть в перечне"
#      end
#    end
    @carriages.store(train_type, carriage_name)
  end

  def self.show_carriages
    @carriages.each_pair { |key, value| puts "Есть вагоны: #{key} #{value}"}
  end
end