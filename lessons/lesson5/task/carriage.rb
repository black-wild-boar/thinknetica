require './modules/company_name.rb'

class Carriage
  attr_reader :number
  include CompanyName

  def initialize(number)
    @number = number
  end

protected
  attr_writer :number
end