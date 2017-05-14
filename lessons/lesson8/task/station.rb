require './modules/instance_counter.rb'

class Station
  include InstanceCounter

  attr_reader :name, :train

  STATION_PATTERN = /^[a-zA-Z0-9]{2,}$/

  @@stations = {}

  def initialize(name)
    @name = name
    validate!
    @train = {}
  end

  def each_train
    train.values.each { |train| yield(train) }
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise 'Wrong station name format' if @name !~ STATION_PATTERN
    true
  end

  def add_train(train)
    @train[train.number] = train
  end

  def del_train(train_number)
    @train.delete(train_number)
  end
#+
  def list
    @@stations ||= 0
    p @@stations
  end

  def add(station)
    @@stations ||= {}
    p @@stations
    @@stations[station.name] = station
p station
    p @@stations
  end

  def exist(station)
    true if @stations.key?(station)
  end

  def del(station)#m_remove_station
    if @@stations.key?(station)
      @@stations.delete(station)
    else
      p 'No station'
    end
  end

end
