# С этого занятия мы будем создавать объектную модель (классы и методы) для гипотетического приложения управления железнодорожными станциями, которое позволит управлять станциями, принимать и отправлять поезда, показывать информацию о них и т.д.

# Требуется написать следующие классы:

# +2Класс Station (Станция):
# +2Имеет название, которое указывается при ее создании
# +5Может принимать поезда (по одному за раз)
# +5Может показывать список всех поездов на станции, находящиеся в текущий момент
# +5Может показывать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
# +5Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

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
#+4 Может принимать маршрут следования (объект класса Route)
#+4 Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
#+4 Показывать предыдущую станцию, текущую, следующую, на основе маршрута

# В качестве ответа приложите ссылку на репозиторий с решением.

#{stations: {station: }}
#{station: train}

#{trains: {train:}}
#{train: {number: ,speed: ,type: ,vagons: ,route: [station_first, station_current, station_last]} }

#{routs: {route: }}
#{route: => [station_first, station_last]}

#интересены возможности синтаксиса
#Hash.new { |hash, key| hash[key] =  }
#@stations = {self => station_name}

#l3-1
class Station
  attr_reader :station_name, :stations, :trains

  @stations = {}

  def initialize(station_name)
    @station_name = station_name
    @trains   = []
  end

  def self.station_add(station)
    @stations.store(station.station_name, station)
  end

  def self.stations_show_all
    @stations.each { |station| puts "#{station.inspect}" }
  end

  def train_add(train)
    self.trains << train
    train.station = self
  end

  def show_all_trains
    self.trains.each { |train| puts "На станции #{self.station_name} поезд #{train}"}
  end

  def show_all_trains_by_type(type)
    self.trains.each { |train| puts "На станции #{self.station_name} поезд #{train}. Тип поезда #{type}" if train.type == type}
  end

  def train_go_away(train)
    puts "Пока... паравозик!"
    self.trains.delete(train)
  end

end

class Route
  attr_reader :routes, :route, :station_first, :station_last

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
  #type: cargo = 0, carriage = 1 
  attr_accessor :trains, :number, :type, :carriges_count, :speed, :route, :station

  @trains = {}

  def initialize(number, type, carriges_count)
    @number         = number
    @type           = type
    @carriges_count = carriges_count
    @speed          = 0
    @route          = nil
    @station        = nil
  end

  def self.train_add_to_trains(train)
    @trains.store(train.number, train)
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
    puts "Вагонов в поезде: #{@carriges_count}"
  end

  def carriage_count_up
    self.carriges_count += 1
  end

  def carriage_count_down
    if self.carriges_count <= 0
      puts "Поезд ничего не знает про вагоны-призраки"
    else
      self.carriges_count -= 1
    end
  end

  def train_add_route(route)
    @route = route
  end

  def train_goto_station(station)
    #if self.route.nil? || !self.route.route.include?(station)
    #  puts "Поезда не летают между станциями"
    @station = station
  end

  def train_next_station
    if !self.route.route.include?(self.station) 
      puts "Текущей станции нет в маршруте" 
    elsif self.route.route.find_index(self.station) >= self.route.route.count-1
      puts "Уже конечная"
    else
      puts "Текущая станция #{self.station}"
      puts "Чух-чух-чух... поезд прибывает на станцию #{self.route.route[self.route.route.find_index(self.station)+1]}"  
      self.station = self.route.route[self.route.route.find_index(self.station)+1]
      puts "Поезд причухал на станцию  #{self.station}"
    end
  end

  def train_prev_station
    if !self.route.route.include?(self.station) 
      puts "Текущей станции нет в маршруте" 
      
    elsif self.route.route.find_index(self.station) <= 0
      puts "Уже начальная"
    else
      puts "Текущая станция #{self.station}"
      puts "Чух-чух-чух... поезд прибывает на станцию #{self.route.route[self.route.route.find_index(self.station)-1]}"  
      self.station = self.route.route[self.route.route.find_index(self.station)]
      puts "Поезд причухал на станцию  #{self.station}"
    end
  end

  def train_around_station
    if !self.route.route.include?(self.station) 
      puts "Текущей станции нет в маршруте" 
      
    elsif self.route.route.find_index(self.station) <= 0 || self.route.route.find_index(self.station) >= self.route.route.count-1
      puts "Уже начальная/конечная"
    else
      puts "Текущая станция #{self.station}"
      puts "Предыдущая станция: #{self.route.route[self.route.route.find_index(self.station)-1]}"
      puts "Следующая станция: #{self.route.route[self.route.route.find_index(self.station)+1]}"
    end
  end

end

s1 = Station.new('a1')
s2 = Station.new('b1')
s3 = Station.new('c1')

puts "s1=#{s1}"
puts "s2=#{s2}"
puts "s3=#{s3.inspect}"

r1 = Route.new(s1,s2)
r2 = Route.new(s1,s3)

puts "r1=#{r1}"
puts "r2=#{r2.inspect}"

r2.route_add_station(s2)

puts "r2=#{r2.inspect}"

t1 = Train.new(101,0,10)
t2 = Train.new(201,1,20)

puts "t1=#{t1}"
puts "t2=#{t2}.inspect"

Train.train_add_to_trains(t1)
Train.train_add_to_trains(t2)

puts "Все поезда"
Train.trains_show_all

puts "Добавлен маршрут к поезду"
 t1.train_add_route(r2)
puts "Поезд #{t1.inspect}"

t1.train_goto_station(s1)
puts t1.station

t1.train_next_station
puts t1.station

t1.train_around_station

t1.train_prev_station
puts t1.station

s1.train_add(t1)

puts "s1: #{s1.inspect}"

s1.train_add(t2)

puts "s1: #{s1.inspect}"

s1.show_all_trains

s1.show_all_trains_by_type(0)

s1.train_go_away(t1)

s1.show_all_trains