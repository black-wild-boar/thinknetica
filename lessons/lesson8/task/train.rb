require './modules/company_name.rb'
require './modules/instance_counter.rb'

class Train
  attr_accessor :number, :route, :carriages, :current_station_id, :speed
  include CompanyName
  include InstanceCounter

  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  @@all_trains = {}

  def initialize(number)
    @number = number
    validate!
    @speed               = 0
    @carriages           = {}
    @@all_trains[number] = self
  end

  def each_carriage(&block)
    carriages.values.each { |carriage| yield(carriage) }
  end

  def self.all
    @@all_trains
  end

  def valid?
    validate!
  rescue
    false
  end

  def validate!
    raise 'Неверный формат номера поезда' if @number !~ TRAIN_PATTERN
    true
  end

  def self.find(number)
    @@all_trains[number]
  end
  #++
  def set_current_station(station)
    if route.stations.include?(station)
      self.current_station_id = station
    else
      puts 'В маршруте нет такой станции'
    end
  end

#++
  def next_station
    station_index = route.stations.index(current_station_id)
    if (station_index + 1) < route.stations.count
      self.current_station_id = route.stations.fetch(station_index + 1)
    else
      puts 'Конечная. На выход'
    end
  end
#++
  def prev_station
    if station_index > route.stations.index(route.stations.first)
      self.current_station_id = route.stations.fetch(station_index - 1)
    else
      puts 'Станция 0'
    end
  end

  def speed_show
    puts "Текущая скорость: #{@speed}"
  end
#++
  def del_carriage(carriage)
    if speed == 0
      carriages.delete(carriage.number)
    else
      puts 'Индиана Джонс пытается отцепить вагоны на бегу'
    end
  end
#++
  def add_route(route_name)
    self.route = route_name
  end
#++
  def carriage_include?(carriage)
    carriages.keys.include?(carriage.number)
  end

  #++
  def add_carriage(carriage)
    if speed == 0 && !carriage_include?(carriage)
      carriages[carriage.number] = carriage
    else
      puts 'Бегущий поезд лани подобен'
    end
  end

# то, что должны наследовать потомки
protected

  def speed_up(speed)
    if speed <= 0
      puts 'Скорость не может быть меньше 0'
    else
      @speed += speed
    end
  end

  def speed_down(speed)
    if speed < 0 || (self.speed - speed) < 0
      puts 'Скорость не может быть меньше 0'
    else
      @speed -= speed
      puts 'Поезд остановлен' if self.speed == 0
    end
  end
end