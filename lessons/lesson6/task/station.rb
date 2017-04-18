require './modules/instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name

  @@all_stations = {}

  def initialize(name)
    @name                = name
    @@all_stations[name] = self
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