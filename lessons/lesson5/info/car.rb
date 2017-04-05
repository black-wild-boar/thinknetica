class Car
  attr_reader :current_rpm

#переменные класса
@@instances = 0

#метод класса
  def self.descriptions
    puts "метод класса"
  end

#метод инстанса
  def descriptions
    puts "метод инстанса"
  end

#блок методов класса
  class << self
    def instances
      @@instances
    end

    def debug(log)
      puts "Debug:  #{log} !!!"
    end
  end

  debug 'Start interface'


  def initialize
    @current_rpm = 0
    @@instances += 1
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  debug 'End interface'

  protected

  attr_writer :current_rpm

  #INITIAL_RPM = 500
  def initial_rpm 
    700
  end

  def engine_stopped?
    current_rpm.zero?
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  def stop
  end
end