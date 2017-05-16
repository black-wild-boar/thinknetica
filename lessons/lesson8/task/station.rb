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
    @@stations[name] = self
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

  def list
    p @@stations
  end

  def add(station)
    @@stations ||= {}
    @@stations[station.name] = station
  end

  def self.exist?(station)
    true unless @@stations[station].nil?
  end

  def del(station)
    if @@stations.key?(station)
      @@stations.delete(station)
    else
      p 'No station'
    end
  end

  def self.find(station)
    @@stations[station] unless @@stations[station].nil?
  end

  def trains_on_station
    p @train.keys
  end
end
