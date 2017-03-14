# С этого занятия мы будем создавать объектную модель (классы и методы) для гипотетического приложения управления железнодорожными станциями, которое позволит управлять станциями, принимать и отправлять поезда, показывать информацию о них и т.д.

# Требуется написать следующие классы:

# +2Класс Station (Станция):
# +2Имеет название, которое указывается при ее создании
# Может принимать поезда (по одному за раз)
# Может показывать список всех поездов на станции, находящиеся в текущий момент
# Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

# Класс Route (Маршрут):
#+3 Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
#+3 Может добавлять промежуточную станцию в список
#+3 Может удалять промежуточную станцию из списка
#+3 Может выводить список всех станций по-порядку от начальной до конечной

# Класс Train (Поезд):
#+1 Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
#+1 Может набирать скорость
#+1 Может показывать текущую скорость
#+1 Может тормозить (сбрасывать скорость до нуля)
#+1 Может показывать количество вагонов
#+1 Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
# Может принимать маршрут следования (объект класса Route)
# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
# Показывать предыдущую станцию, текущую, следующую, на основе маршрута

# В качестве ответа приложите ссылку на репозиторий с решением.

#{stations: {station: }}
#{station: train}

#{trains: {train:}}
#{train: {number: ,speed: ,type: ,vagons: ,route: [station_first, station_current, station_last]} }

#{routs: {route: }}
#{route: => [station_first, station_last]}

#интересен синтаксис
#Hash.new { |hash, key| hash[key] =  }
#@stations = {self => station_name}

#l3-1
class Station
  attr_reader :station_name, :stations

  @stations = {}

  def initialize(station_name)
    @station_name = station_name
  end

  #def train_add(train_number)
  #  trains[train] = Train.new(train_number)
  #end

  def self.station_add(station)
    @stations.store(station.station_name, station)
  end

  def self.stations_show_all
    @stations.each { |station| puts "#{station.inspect}" }
  end
end

class Route
  attr_reader :routes, :route, :route_title, :station_first, :station_last

  @route = []
  @routes = {}

  def initialize(station_first, station_last)
    @route = [station_first, station_last]
  end

  def self.route_add_to_routes(route_name, route)
    @routes.store(route_name, route)    
  end

  def self.routes_show_all
    @routes.each { |route| puts "Маршрут: #{route.inspect}"}
  end

  def route_show_stations
    @route.each { |station| puts station}
  end

  def route_add_station(station)
    if @route.include?(station)
      puts "Есть уже такая станция"
    else
      @route.insert(1, station)
    end
  end

  def route_del_station(station)
    if !@route.include?(station)
      puts "Такой станции нет"
    else
      @route.delete(station)
    end
  end
end

class Train
  #attr_reader 
  attr_accessor :trains, :train_number, :train_type, :train_carriges_count, :speed

  @trains = {}

  def initialize(train_number, train_type, train_carriges_count)
    @train_number         = train_number
    @train_type           = train_type
    @train_carriges_count = train_carriges_count
    @speed                = 0
  end

  def self.train_add(train)
    @trains.store(train.train_number, train)
  end

  def self.trains_show_all
    @trains.each { |train| puts "#{train}"}
  end

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

  def speed_show
    puts "Текущая скорость: #{@speed}"
  end

  def carriage_count
    puts "Вагонов в поезде: #{@train_carriges_count}"
  end

  def carriage_count_up
    self.train_carriges_count += 1
  end

  def carriage_count_down
    if self.train_carriges_count <= 0
      puts "Поезд ничего не знает про вагоны-призраки"
    else
      self.train_carriges_count -= 1
    end
  end

end
