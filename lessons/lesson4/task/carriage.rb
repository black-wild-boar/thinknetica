class Carriage
  attr_reader :number

  @carriages_list = Hash.new

  def initialize(number)
    @number = number
  end

#  def self.init_hash
#    @carriages[self.class.name.to_sym] = []
#  end

#
protected
  attr_writer :number

#должен существовать общий реестр вагонов
  def self.add_to_carriage_list(carriage)
    if @carriages_list.empty?
      puts "empty"
      @carriages_list[carriage.class.name.to_sym] = []
      @carriages_list[carriage.class.name.to_sym] << carriage.number
    elsif !@carriages_list.include?(carriage.class.name.to_sym) 
      puts "empty not"
      @carriages_list[carriage.class.name.to_sym] = []
      @carriages_list[carriage.class.name.to_sym] << carriage.number
    else
      puts "empty not yes"
      if !@carriages_list[carriage.class.name.to_sym].include?(carriage.number)
        @carriages_list[carriage.class.name.to_sym] << carriage.number
      else
        puts "Номер вагона уже есть в перечне"
      end
    end
  end

  def self.show_carriages
    @carriages_list.each_pair { |key, value| puts "Есть вагоны: #{key} #{value}"}
  end
end