require './modules/company_name.rb'
require './modules/instance_counter.rb'

class Train
  attr_accessor :number, :route, :carriages, :station_id, :speed
  include CompanyName
  include InstanceCounter

  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  @all_trains = {}
  @@trains = {}

  def initialize(number)
    @number = number
    validate!
    @speed               = 0
    @carriages           = {}
    # @all_trains[number] = self
  end
#+
  def add(train)
    @@trains ||= {}
    @@trains[train.number] = train
  end
#+
  def del(train)
    @@trains.delete(train) if Train.exist?(train)
  end
#+
  def list
    p @@trains
  end
#+
  def self.exist?(train) true unless @@trains[train].nil? end
#+
  def add_route(train, route)
    if Train.exist?(train) && Route.exist?(route)
      @@trains[train].route = route
    else
      p 'No such train/route'
    end
  end
#+
  def add_wagon(wagon)
    self.carriages[wagon.number] = wagon if speed.zero?
  end
#+
  def del_wagon(wagon)
    p exist_wagon?(wagon)
    if speed.zero? && exist_wagon?(wagon)
      self.carriages.delete(wagon)
    else
      p 'no such wagon or speed !0'
    end
  end
#+
  def exist_wagon?(wagon)
    self.carriages.key?(wagon)
  end
#+
  def valid?
    validate!
  rescue
    false
  end
#+
  def validate!
    raise 'Wrong train number' if @number !~ TRAIN_PATTERN
    true
  end
#+
  def self.find(number)
    @@trains[number]
  end
#+- 
  def set_station(station)
    route = Route.find(self.route)
    self.station_id = route.index(station) + 1 unless route.nil?
  end
#+
  def next_station
    route = Route.find(self.route)
      self.station_id += 1 unless route.count == self.station_id
      p route.count
      p self.station_id
  end
#+
  def prev_station
    self.station_id -= 1 if self.station_id > 1
  end
  # def go_current_station(station)
  #   if route.stations.include?(station)
  #     self.current_station_id = station
  #   else
  #     puts 'No station on route'
  #   end
  # end

  # def station_index
  #   route.stations.index(current_station_id)
  # end

  # def next_station
  #   if (station_index + 1) < route.stations.count
  #     self.current_station_id = route.stations.fetch(station_index + 1)
  #   else
  #     puts 'Last station'
  #   end
  # end

  # def prev_station
  #   if station_index > route.stations.index(route.stations.first)
  #     self.current_station_id = route.stations.fetch(station_index - 1)
  #   else
  #     puts 'First station'
  #   end
  # end

  def speed_show
    puts "Current speed: #{@speed}"
  end

  # def del_carriage(carriage)
  #   if speed.zero?
  #     carriages.delete(carriage.number)
  #   else
  #     puts "Cann't delete carriage if speed > 0"
  #   end
  # end

  # def add_route(route_name)
  #   self.route = route_name
  # end

  def carriage_include?(carriage)
    carriages.keys.include?(carriage.number)
  end

  # def add_carriage(carriage)
  #   if speed.zero? && !carriage_include?(carriage)
  #     carriages[carriage.number] = carriage
  #   else
  #     puts "Cann't add carriage if speed > 0"
  #   end
  # end

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
