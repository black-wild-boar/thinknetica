class Train
  attr_accessor :trains, :number, :route #:carriges_count
  attr_reader :type, :speed, :current_station_id

  @trains = {}

  def initialize(number, carriges_count)
    @number         = number
    @carriges_count = carriges_count
    @speed          = 0
    @type = self.class
    @carriages = []
  end

  def self.trains_show_all
    @trains.each { |train| puts "#{train}"}
  end

  def speed_show
    puts "Текущая скорость: #{@speed}"
  end

  def carriage_count
    puts "Вагонов в поезде: #{@carriges_count}"
  end

  def show_current_station
    puts "Текущая станция: #{route.stations[current_station_id]}"
  end

  def show_station_next
    if route.stations.count-current_station_id < 0
      puts "Текущей станции нет в маршруте"
    elsif route.stations.count-1 == current_station_id
      puts "Уже конечная"
    else
      puts "Следующая станция: #{route.stations[current_station_id+1]}"
    end
  end

  def show_station_prev
    if route.stations.count-current_station_id < 0
      puts "Текущей станции нет в маршруте" 
    elsif current_station_id.zero?
      puts "Уже начальная"
    else
      puts "Предыдущая станция: #{route.stations[current_station_id-1]}"
    end
  end

  def self.train_add_to_trains(train)
    @trains.store(train.number, train)
  end

#если поезд стоит  - добавить вагон
  def carriage_add(number)
    if self.speed == 0
      @carriages << Carriage.new(number)
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
  attr_writer :type, :speed, :current_station_id 
  attr_accessor :trains
end



