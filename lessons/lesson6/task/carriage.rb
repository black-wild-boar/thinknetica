require './modules/company_name.rb'
require './modules/instance_counter.rb'

class Carriage
  include CompanyName
  include InstanceCounter

  attr_reader :number

  def initialize(number)
    @number = number
    register_instance
  end

protected
  attr_writer :number
end