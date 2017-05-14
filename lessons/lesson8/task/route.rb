class Route
  attr_reader :stations
  #attr_accessor :routes
  @@routes = {}

  def initialize(name, first, last)
    @stations = [first, last]
    @@routes[name] = @stations
  end

  def list
    p @@routes
  end

  def del(route)
    if @@routes.key?(route)
      @@routes.delete(route)  
    else
      p 'Wrong route!'
    end
  end

  def add_station(station)
    if stations.include?(station)
      puts 'Current station exist'
    else
      stations.insert(-2, station)
    end
  end

  def del_station(station)
    if !stations.include?(station)
      puts 'No station on route'
    else
      stations.delete(station)
    end
  end
end
