class Route
  attr_reader :routes, :stations

  @routes = {}

  def initialize(station_first, station_last)
    @stations= [station_first, station_last]
  end

  #+
  def self.add_to_routes(route_name, route)
    @routes.store(route_name, route)
  end

  #+
  def self.show_all
    @routes.each { |route| puts "Маршрут: #{route.inspect}"}
  end

#+
  def self.remove_from_routes(route_name)
    @routes.delete(route_name) if @routes.include?(route_name)
  end

  def self.include_route?(route_name)
    @routes.keys.include?(route_name)
  end

  #+
  #def self.add_station(station)
  #  if @stations.include?(station)
  #    puts "Есть уже такая станция"
  #  else
  #    @stations.insert(-1, station)
  #  end
  #end
  def self.add_station(station, route)
      
    if @stations.include?(station)
      puts "Есть уже такая станция"
    else
      route.@stations.insert(-1, station)
    end
  end

  #+
  def self.remove_station(station)
    if !@stations.include?(station)
      puts "Такой станции нет"
    else
      @routes.delete(station)
    end
  end
end