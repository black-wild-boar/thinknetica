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