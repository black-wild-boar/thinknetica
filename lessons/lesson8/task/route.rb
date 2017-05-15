class Route
  attr_reader :stations

  @@routes = {}

  def initialize(name, first, last)
    @stations = [first, last]
    @@routes[name] = @stations
  end
#+
  def list
    p @@routes
  end
#+
  def del(route)
    if @@routes.key?(route)
      @@routes.delete(route)  
    else
      p 'Wrong route!'
    end
  end
#+
  def self.exist?(route) true unless @@routes[route].nil? end
    # if @@routes[route].nil?
    #   p 'No such route'
    #   false
    # else
    #   true 
    # end
  # end
#+
  def add_station(route, station)
    if Route.exist?(route) && Station.exist?(station)
      @@routes[route].insert(-2, station)
    else
      p 'No such route/station!'
    end
  end
#+
  def del_station(route, station)
    if Route.exist?(route) && Station.exist?(station)
      p @@routes[route].count
      @@routes[route].delete(station) if @@routes[route].count > 2
    else
      p 'No such route/station!'
    end
  end
#+
  def self.find(route) @@routes[route] unless @@routes[route].nil? end
    #p @@routes[route].nil?
    #@@routes[route] if !@@routes.nil?(route)
  #end
  #def station_exist?(station) true if @@route

  #end
end
