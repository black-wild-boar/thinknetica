require './modules/instance_counter.rb'
#require './modules/validate.rb'

class Station
  include InstanceCounter
  #include Validate

  attr_reader :name

  STATION_PATTERN = /^[a-zA-Z0-9]{2,}$/

  @@all_stations = {}

  def initialize(name)
    @name                = name
    validate!
    @@all_stations[name] = self
    #valid?(name)
  end

  def valid?
    validate!
    rescue
    false
  end

  def validate!
    raise "Неверный формат номера станции" if @name !~ STATION_PATTERN
    true
  end

  def add_train(train)
    self.trains << train
  end

  def del_train(train)
    self.train.delete(train)
  end

  def self.all
    @@all_stations
  end
end