class Route
  attr_reader :stations

  def initialize(station_first, station_last)
    @stations = [station_first, station_last]
  end

  def add_station(station)
    if stations.include?(station)
      puts 'Есть уже такая станция или маршрута нет'
    else
      stations.insert(-2, station)
    end
  end

  def del_station(station)
    if !stations.include?(station)
      puts 'Нет станции на маршруте'
    else
      stations.delete(station)
    end
  end
end
