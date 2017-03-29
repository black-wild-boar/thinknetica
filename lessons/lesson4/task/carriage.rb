class Carriage
  attr_reader :number, :type

  def initialize(number)
    @number = number
    @type = self.class
  end

protected
  attr_writer :number
end