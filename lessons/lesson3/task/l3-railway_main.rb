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
  attr_reader :name, :trains

  @stations = {}

  def initialize(name)
    @name = name
    @trains   = []
  end

  def self.station_add(station)
    @stations.store(station.name, station)
  end

  def self.stations_show_all
    @stations.each { |station| puts "#{station.inspect}" }
  end

  def train_add(train)
    trains << train
    train.station = self
  end

  def show_all_trains
    trains.each { |train| puts "На станции #{self.name} поезд #{train}"}
  end

  def show_all_trains_by_type(type)
    trains.each { |train| puts "На станции #{self.name} поезд #{train}. Тип поезда #{type}" if train.type == type}
  end

  def train_go_away(train)
    puts "Пока... паравозик!"
    trains.delete(train)
  end

end

class Route
  attr_reader :routes, :stations

  @routes = {}

  def initialize(station_first, station_last)
    @stations = [station_first, station_last]
  end

  def self.route_add_to_routes(route_name, route)
    @stations.store(route_name, route)    
  end

  def self.routes_show_all
    @routes.each { |route| puts "Маршрут: #{route.inspect}"}
  end

  def route_add_station(station)
    if @stations.include?(station)
      puts "Есть уже такая станция"
    else
      @stations.insert(-1, station)
    end
  end

  def route_del_station(station)
    if !@stations.include?(station)
      puts "Такой станции нет"
    else
      @stations.delete(station)
    end
  end

end

class Train
  attr_accessor :trains, :number, :type, :carriges_count, :speed, :route, :station

  @trains = {}

  def initialize(number, type, carriges_count)
    @number         = number
    @type           = type
    @carriges_count = carriges_count
    @speed          = 0
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
    if self.speed == 0
      self.carriges_count += 1
    else
      puts "Бегущему поезду вагон не добавить)))"
    end
  end

  def carriage_count_down
    if self.carriges_count <= 0 || self.speed != 0
      puts "Поезд ничего не знает про вагоны-призраки, да и скорость для добавления вагона должна быть = 0"
    else
      self.carriges_count -= 1
    end
  end

  def forward
    if !station.between?(0,route.stations.count-1)
      puts "Текущей станции нет в маршруте" 
    elsif station >= route.stations.count-1
      puts "Уже конечная"
    else
      puts "Текущая станция #{station}"
      self.station += 1
      puts "Чух-чух-чух... поезд причухал на станцию #{station}" 
    end
  end

  def backward
    if station.between?(0,route.stations.count-1) && self.station == 0
      puts "Уже начальная"
    else
      puts "Текущая станция #{station}"
      self.station -= 1
      puts "Чух-чух-чух... поезд причухал на станцию #{station}"  
    end
  end

  def current_station(station)
    route.stations.each_with_index { |station, index| puts "На маршруте есть номер станции: #{index}" }
    if route.stations.index(station).between?(0,route.stations.count)
      self.station = route.stations.find_index(station)
      puts "Текущая станция № #{self.station}"
    else
      puts "Неправильно ты, Дядя Фёдор, номера станции готовишь"
    end
  end

  def show_station_next
    if route.stations.count-self.station < 0
      puts "Текущей станции нет в маршруте"
    elsif route.stations.count-1 == self.station
      puts "Уже конечная"
    else
      puts "Следующая станция: #{self.station+1}"
    end
  end

  def show_station_prev
    if route.stations.count-self.station < 0
      puts "Текущей станции нет в маршруте" 
    elsif self.station.zero?
      puts "Уже начальная"
    else
      puts "Предыдущая станция: #{self.station-1}"
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

puts "#{r1.stations}"

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
t1.route=(r2)

puts "Поезд #{t1.inspect}"

t1.station=(s1)
puts t1.station

t1.current_station(s1)

puts "forward"
t1.forward
puts t1.station

t1.show_station_next
t1.show_station_prev

t1.backward
puts t1.station

s1.train_add(t1)

puts "s1: #{s1.inspect}"

s1.train_add(t2)

puts "s1: #{s1.inspect}"

s1.show_all_trains

s1.show_all_trains_by_type(0)

s1.train_go_away(t1)

s1.show_all_trains