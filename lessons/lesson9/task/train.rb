require './modules/company_name.rb'
require './modules/instance_counter.rb'
require './modules/l9validation.rb'

class Train
  attr_accessor :number, :route, :wagons, :station_id, :speed
  include CompanyName
  include InstanceCounter
  include Validation

  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  # validate :number, :format, TRAIN_PATTERN
  validate :speed, :type, Integer
  validate :number, :presence

  @@trains = {}

  def initialize(number)
    @number = number
    @speed  = 0
    validate!
    @wagons = {}
    
  end

  def validate
    self.validate!
  end

  def add(train)
    @@trains ||= {}
    @@trains[train.number] = train
  end

  def del(train)
    @@trains.delete(train) if Train.exist?(train)
  end

  def list
    p @@trains
  end

  def self.exist?(train)
    true unless @@trains[train].nil?
  end

  def add_route(train, route)
    if Train.exist?(train) && Route.exist?(route)
      @@trains[train].route = route
    else
      p 'No such train/route'
    end
  end

  def add_wagon(wagon)
    wagons[wagon.number] = wagon if speed.zero?
  end

  def del_wagon(wagon)
    p exist_wagon?(wagon)
    if speed.zero? && exist_wagon?(wagon)
      wagons.delete(wagon)
    else
      p 'no such wagon or speed !0'
    end
  end

  def exist_wagon?(wagon)
    wagons.key?(wagon)
  end

  # def valid?
  #   validate!
  # rescue
  #   false
  # end

  # def validate!
  #   raise 'Wrong train number' if @number !~ TRAIN_PATTERN
  #   true
  # end

  def self.find(number)
    @@trains[number]
  end

  def current_station(station)
    route_stations = Route.find(route)
    self.station_id = route_stations.index(station) + 1
    station_object = route_stations.fetch(station_id - 1)
    Station.find(station_object).add_train(self)
    return unless route.nil?
  end

  def next_station
    route_stations = Route.find(route)
    add_station(route_stations)
    del_station(route_stations)
    self.station_id += 1
    return unless route_stations.count == station_id
  end

  def del_station(route_stations)
    station_name = route_stations.fetch(station_id - 1)
    Station.find(station_name).del_train(self)
    return unless route.nil?
  end

  def add_station(route_stations)
    puts "route.nil? #{route.nil?}"
    station_name = route_stations.fetch(station_id)
    Station.find(station_name).add_train(self)
    return unless route.nil?
  end

  def prev_station
    route_stations = Route.find(route)
    self.station_id -= 1
    add_station(route_stations)
    del_station(route_stations)
    return if self.station_id > 1
  end

  def wagons_list
    p @wagons.keys unless @wagons.nil?
  end

  def cargo_wagon_employ(wagon, volume)
    wagons[wagon].occupie_volume(volume)
  end

  def passenger_wagon_employ(wagon)
    wagons[wagon].occupie_seat
  end

  def cargo_wagon_release(wagon, volume)
    wagons[wagon].release_volume(volume)
  end

  def passenger_wagon_release(wagon)
    wagons[wagon].release_seat
  end

  def speed_show
    puts "Current speed: #{@speed}"
  end

  protected

  def speed_up(speed)
    if speed <= 0
      puts 'Speed must be > 0'
    else
      @speed += speed
    end
  end

  def speed_down(speed)
    if speed < 0 || (self.speed - speed) < 0
      puts 'Speed must be > 0'
    else
      @speed -= speed
      puts 'Speed = 0' if self.speed.zero?
    end
  end
end

# Validate test

# initialize
t = Train.new('D')

# instance method
t.validate