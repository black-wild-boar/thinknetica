class Carriage
  attr_reader :number

  def initialize(number)
    @number = number
  end

protected
  attr_writer :number
end