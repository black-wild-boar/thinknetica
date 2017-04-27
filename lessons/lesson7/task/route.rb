class Route
  attr_reader :stations

  def initialize(station_first, station_last)
    @stations= [station_first, station_last]
  end

  def add_station(station)
    if self.stations.include?(station)
      puts "Current station exist"
    else
      self.stations.insert(-2, station)
    end
  end

  def del_station(station)
    if !self.stations.include?(station)
      puts "No station on route"
    else
      self.stations.delete(station)
    end
  end
end