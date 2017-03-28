class Route
  attr_reader :routes, :stations

  @routes = {}

  def initialize(station_first, station_last)
    @stations= [station_first, station_last]
  end

#++--
  def remove_from_routes
    puts @@all_routes
  end

  #++
  def add_station(station)
    if @@all_routes[self].include?(station) || !@@all_routes.keys.include?(self)
      puts "Есть уже такая станция или маршрута нет"
    else
      @@all_routes[self].insert(-2, station)
    end
  end
end