module FuelTank
  def fill_tank(level)
    self.fuel_tank = level
  end

  def fuel_level
    self.fuel_tank
  end

  protected
  attr_accessor :fuel_tank
end

module Debugger # == Debugger = Module.new do ...end
  # в параметр base будет передаваться сам метод, в который подключаю модуль
  def self.included(base)
    base.extend ClassMethods
    #вызов метода == отправка сообщения (send для работы с приватными методами)
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def debug(log)
      puts "Debug:  #{log} !!!"
    end
  end
  module InstanceMethods
    def debug(log)
      self.class.debug(log)
    end
    def print_class
      puts self.class
    end
  end
end

class Car # == Car = Class.new do ... end
#включает методы модуля как методы инстанса (экземпляра класса)
  include FuelTank
#включает методы модуля как методы класса
  #extend Debugger::ClassMethods
  #include Debugger::InstanceMethods
# т.к. self.included(base)
  include Debugger

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

#блок объявления методов класса
  class << self
    def instances
      @@instances
    end

  end

  debug 'Start interface'


  def initialize
    @current_rpm = 0
    @@instances += 1
    debug 'initialize'
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

class MotoBike
  include FuelTank
  include Debugger

  debug 'Motobike class'
end