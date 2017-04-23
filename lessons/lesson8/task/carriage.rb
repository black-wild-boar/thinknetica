require './modules/company_name.rb'
require './modules/instance_counter.rb'

class Carriage
  include CompanyName
  include InstanceCounter

  attr_reader :number

  CARRIAGE_PATTERN = /^[a-zA-Z0-9]{2,}$/

  def initialize(number)
    @number = number
    validate!
    register_instance
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise 'Неверный формат номера вагона' if @number !~ CARRIAGE_PATTERN
    true
  end

protected

  attr_writer :number
end
