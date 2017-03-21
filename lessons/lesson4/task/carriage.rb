class Carriage
  attr_accessor :number

  @carriages = Hash.new

  def initialize(number)
    @number = number
  end

  def self.init_hash
    @carriages[self.class.name.to_sym] = []
  end

  def self.add_to_carriages(carriage)
    if @carriages.empty?
      puts "empty"
      @carriages[carriage.class.name.to_sym] = []
      @carriages[carriage.class.name.to_sym] << carriage.number
    elsif !@carriages.include?(carriage.class.name.to_sym) 
      puts "empty not"
      @carriages[carriage.class.name.to_sym] = []
      @carriages[carriage.class.name.to_sym] << carriage.number
    else
      puts "empty not yes"
      if !@carriages[carriage.class.name.to_sym].include?(carriage.number)
        @carriages[carriage.class.name.to_sym] << carriage.number
      else
        puts "Номер вагона уже есть в перечне"
      end
    end
  end

  #def carriage_type
  #  self.class.name.to_sym
  #end

  def self.show_carriages
    #@carriages
    @carriages.each_pair { |key, value| puts "Есть вагоны: #{key} #{value}"}
  end
end