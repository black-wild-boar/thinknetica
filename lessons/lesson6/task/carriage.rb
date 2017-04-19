require './modules/company_name.rb'
require './modules/instance_counter.rb'
require './modules/validate.rb'

class Carriage
  include CompanyName
  include InstanceCounter
  include Validate

  attr_reader :number

  def initialize(number)
    @number = number
    register_instance
    valid?(number)
  end

protected
  attr_writer :number
end