class Train
  attr_accessor :trains, :number, :route, :carriages, :current_station_id
  attr_reader :type, :speed

  @trains = {}
 
  def initialize(number)
    @number         = number
    @speed          = 0
    @type           = self.class
    @carriages      = []
  end
  #+
  def self.trains_show_all
    @trains.each { |train| puts "#{train}"}
  end
  #+
  def self.train_include?(train_name)
    @trains.keys.include?(train_name)
  end

#
  def self.get_type(train_name)
    @trains[train_name].type
  end

  def self.check_station_on_route(train_name, station)
    #при условии, что маршрут обязательно должен быть заполнен
    if @trains[train_name].route.nil?
      puts "Поезд не имеет маршрута. Он в поле"
    elsif !@trains[train_name].route.stations.include?(station)
      puts "Этой станции не наблюдается на маршруте"
    else
      puts "Внезапно, станция есть на маршруте."
      true 
    end
  end

  #+
  def self.set_current_station(train_name, station)
    @trains[train_name].current_station_id = @trains[train_name].route.stations.index(station)+1 if check_station_on_route(train_name, station) == true 
  end

#конечно же можно было просто += и -= но например нужно чтобы поезд проехал на определенную станцию, но минуя несколько
#+
  def self.next_station(train_name, station)
    if @trains[train_name].route.stations.index(@trains[train_name].route.stations.last) != @trains[train_name].current_station_id
      @trains[train_name].current_station_id += 1 
    else
      puts "Конечная. На выход"
    end
  end
#+
  def self.prev_station(train_name, station)
    if @trains[train_name].route.stations.index(@trains[train_name].route.stations.first) != @trains[train_name].current_station_id
      @trains[train_name].current_station_id -= 1 
    else
      puts "Станция 1"
    end
  end


  def speed_show
    puts "Текущая скорость: #{@speed}"
  end

  def show_current_station
    puts "Текущая станция: #{route.stations[current_station_id]}"
  end

#  def show_station_next
#    if route.stations.count-current_station_id < 0
#      puts "Текущей станции нет в маршруте"
#    elsif route.stations.count-1 == current_station_id
#      puts "Уже конечная"
#    else
#      puts "Следующая станция: #{route.stations[current_station_id+1]}"
#    end
#  end

#  def show_station_prev
#    if route.stations.count-current_station_id < 0
#      puts "Текущей станции нет в маршруте" 
#    elsif current_station_id.zero?
#      puts "Уже начальная"
#    else
#      puts "Предыдущая станция: #{route.stations[current_station_id-1]}"
#    end
#  end

  #+
  def self.add_to_trains(train_name, train)
    #@trains.store(train.number, train)
    @trains.store(train_name, train)
  end

  #+
  def self.remove_from_trains(train_name)
    @trains.delete(train_name)
  end

#+
  def self.carriage_add(train_name, carriage_name)
#    if @trains[train_name].speed == 0 && !@trains[train_name].carriages.include?(carriage_name) && @trains[train_name].type.to_s.gsub('Train','') == carriage_name.class.to_s.gsub('Carriage','')
      #т.о. можно обратиться к классу, через данные в строке. ВЕЩЬ!
      #@carriages << Object.const_get(self.type.to_s.gsub('Train','')+"Carriage").new(carriage)
    
    #if @trains[train_name].speed == 0  #&& !@trains[train_name].carriages.include?(carriage_name)
      #@trains[train_name].carriages << Carriage.carriage_add(Carriage.new(carriage_name))
    if @trains[train_name].speed == 0 
      Carriage.carriage_add(Carriage.new(carriage_name))
      @trains[train_name].carriages << carriage_name
    #  @trains[train_name].carriages = Carriage.carriage_add(Carriage.new(carriage_name)) 
    else
      puts "Бегущий поезд лани подобен"      
    end
  end

  def self.carriage_remove(train_name, carriage)
    if @trains[train_name].speed == 0 
      @trains[train_name].carriages.delete(carriage)
    else
      puts "Индиана Джонс пытается отцепить вагоны на бегу"      
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
  #+
  def self.add_route(train_name, route_name)
    if @trains.include?(train_name) && Route.route_include?(route_name)
      @trains[train_name].route = Route.find_route(route_name)
    else
      puts "Тут маршрутов нет и поездов тоже нет. Безжизненная пустыня"
    end
  end


      #  def carriage_count_up
#    if self.speed == 0 
#      self.carriges_count += 1
#    else
#      puts "Бегущему поезду вагон не добавить)))"
#    end
#  end

#  def carriage_count_down
#    if self.carriges_count <= 0 || self.speed != 0
#      puts "Поезд ничего не знает про вагоны-призраки, да и скорость для добавления вагона должна быть = 0"
#    else
#      self.carriges_count -= 1
#    end
#  end

  def forward
    if !current_station_id.between?(0,route.stations.count-1)
      puts "Текущей станции нет в маршруте" 
    elsif current_station_id >= route.stations.count-1
      puts "Уже конечная"
    else
      puts "Текущая станция #{route.stations[current_station_id]}"
      self.current_station_id += 1
      puts "Чух-чух-чух... поезд причухал на станцию #{route.stations[current_station_id]}" 
    end
  end

  def backward
    if current_station_id.between?(0,route.stations.count-1) && current_station_id == 0
      puts "Уже начальная"
    else
      puts "Текущая станция #{route.stations[current_station_id]}"
      self.current_station_id -= 1
      puts "Чух-чух-чух... поезд причухал на станцию #{route.stations[current_station_id]}"  
    end
  end

private
#поезду не рекомендуется самостоятельно менять тип, скорость и текущую станцию
  attr_writer :type, :speed
  attr_accessor :trains
end



