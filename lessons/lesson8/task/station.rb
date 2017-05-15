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
end
