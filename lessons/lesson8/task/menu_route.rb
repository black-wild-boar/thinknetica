
class MenuRoute

  def initialize
    @@routes = {}
  end

  def add#m_add_route
    p 'Enter route name'
    route = gets.chomp
    p 'Enter first station name'
    first = gets.chomp
    p 'Enter last station name'
    last = gets.chomp
    #@@routes[route] = Route.new(first, last) if @@stations.key?(first && last)
    @@routes[route] = Route.new(first, last) if @@stations.key?(first && last)
  end

  def del#m_remove_route
    p 'Enter route name'
    route = gets.chomp
    if !@routes.key?(route)
      p 'Wrong route!'
    else
      @routes.delete(route)
    end
  end

  def list#m_routes_list
    p @routes
  end

  def m_route_add_station
    p 'Enter route name'
    route = gets.chomp
    p 'Enter station name'
    station = gets.chomp
    if @routes.key?(route) && @stations.key?(station)
      @routes[route].add_station(station)
    else
      p 'Wrong route or station'
    end
  end

  def m_route_remove_station
    p 'Enter route name'
    route = gets.chomp
    p 'Enter station name'
    station = gets.chomp
    if @routes.include?(route) && @routes[route].stations.include?(station)
      @routes[route].del_station(station)
    else
      p 'Wrong route or station'
    end
  end

  def routes_menu
    m_routes
    @choice[gets.chomp].call
  end
end

menu_route = MenuRoute.new
