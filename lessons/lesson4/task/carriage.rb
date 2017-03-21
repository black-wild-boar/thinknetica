class Carriage
  attr_accessor :number

  @carriages = {}

  def initialize(number)
    @number = number
    #add
  end

  def add
    @carriages[carriage_type] << @number
  end

  def carriage_type
    self.class.name.to_sym
  end

  def self.show_carriages
    puts @carriages.inspect
  end

end