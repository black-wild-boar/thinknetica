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
#+
  def valid?
    validate!
  rescue
    false
  end
#+
  def validate!
    raise 'Wrong station name format' if @name !~ STATION_PATTERN
    true
  end

  def add_train(train)
    p @train.inspect
    #p self
    #p @@stations[self]
    #@@stations[self].train[train.number] = train
    @train[train.number] = train
  end

  def del_train(train)
    p @train.inspect
    p train.inspect
    #@@stations[self].delete(train)
    @train.delete(train.number)
  end
#+
  def list
    @@stations ||= 0
    p @@stations
  end
#+
  def add(station)
    @@stations ||= {}
    @@stations[station.name] = station
  end
#+
  def self.exist?(station) true unless @@stations[station].nil? end
    # if @@stations[station].nil?
    #   p 'No such station'
    #   false
    # else
    #   true 
    # end
  #end
#+
  def del(station)#m_remove_station
    if @@stations.key?(station)
      @@stations.delete(station)
    else
      p 'No station'
    end
  end
#+
  def self.find(station) 
    @@stations[station] unless @@stations[station].nil?
  end
#+
  def trains_on_station
    p @train.keys
  end
end
