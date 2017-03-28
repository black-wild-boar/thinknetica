class Station
  attr_reader :name, :trains

  @stations = {}

  def initialize(name)
    @name = name
    @trains   = []
  end
#+
  def station_add(station)
    @stations.store(station.name, station)
  end
#+
  def station_remove(station)
    @stations.delete(station) if @stations.include?(station)
  end
#+
  def stations_show_all
    @stations.each { |station| puts "#{station.inspect}" }
  end

#++--
  def station_include?
    @@all_stations.keys.include?(station)
  end

  def train_add(train)
    trains << train
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