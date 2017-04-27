require './modules/instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :name, :train

  STATION_PATTERN = /^[a-zA-Z0-9]{2,}$/

  @@all_stations = {}

  def initialize(name)
    @name                = name
    validate!
    @@all_stations[name] = self
    @train = {}
  end

  def each_train(&block)    
    self.train.values.each { |train| yield(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise "Wrong station name format" if @name !~ STATION_PATTERN
    true
  end

  def add_train(train)
    @train[train.number] = train
  end

  def del_train(train_number)
    @train.delete(train_number)
  end

  def self.all
    @@all_stations
  end
end
