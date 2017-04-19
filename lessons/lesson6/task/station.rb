require './modules/instance_counter.rb'
require './modules/validate.rb'

class Station
  include InstanceCounter
  include Validate

  attr_reader :name

  @@all_stations = {}

  def initialize(name)
    @name                = name
    @@all_stations[name] = self
    valid?(name)
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