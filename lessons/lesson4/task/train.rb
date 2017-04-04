class Train
  attr_accessor :number, :route, :carriages, :current_station_id, :speed

  def initialize(number)
    @number         = number
    @speed          = 0
    @carriages      = {}#[]
  end

  #++
  def set_current_station(station)
    if self.route.stations.include?(station)
      self.current_station_id = station
    else
      puts "В маршруте нет такой станции"
    end
  end

#++
  def next_station
    if (self.route.stations.index(self.current_station_id) + 1) < self.route.stations.count
      self.current_station_id = self.route.stations.fetch(self.route.stations.index(self.current_station_id)+1)
    else
      puts "Конечная. На выход"
    end
  end
#++
  def prev_station
    if self.route.stations.index(self.current_station_id) > self.route.stations.index(self.route.stations.first)
      self.current_station_id = self.route.stations.fetch(self.route.stations.index(self.current_station_id)-1)
    else
      puts "Станция 0"
    end
  end

  def speed_show
    puts "Текущая скорость: #{@speed}"
  end
#++
  def del_carriage(carriage)
    if self.speed == 0 
      self.carriages.delete(carriage.number)
    else
      puts "Индиана Джонс пытается отцепить вагоны на бегу"      
    end
  end
#++
  def add_route(route_name)
      self.route = route_name
  end
#++
  def carriage_include?(carriage)
    self.carriages.keys.include?(carriage.number)
  end

  #++
  def add_carriage(carriage)
    if self.speed == 0 && !carriage_include?(carriage)
      self.carriages[carriage.number] = carriage
    else
      puts "Бегущий поезд лани подобен"      
    end
  end

#то, что должны наследовать потомки
protected

  def speed_up(speed)
    if speed <= 0
      puts "Скорость не может быть меньше 0"
    else
      @speed += speed
    end
  end

  def speed_down(speed)
    if speed < 0 || (self.speed - speed) <0
      puts "Скорость не может быть меньше 0"
    else
      @speed -= speed
      puts "Поезд остановлен" if self.speed == 0  
    end
  end
end