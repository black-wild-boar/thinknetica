
class MenuRoute

  attr_accessor :route

#+
  def add#m_add_route
    p 'Enter route name'
    name = gets.chomp
    p 'Enter first station name'
    first = gets.chomp
    p 'Enter last station name'
    last = gets.chomp
      @route = Route.new(name, first, last) if Station.exist?(first && last)
  end
#+
  def del#m_remove_route
    p 'Enter route name'
    name = gets.chomp
      @route.del(name)
  end
#+
  def list#m_routes_list
    @route.list unless @route.nil?
  end
#+
  def add_station
    p 'Enter route name'
    route = gets.chomp
    p 'Enter station name'
    station = gets.chomp 
    @route.add_station(route, station)
  end
#+
  def del_station
    p 'Enter route name'
    route = gets.chomp
    p 'Enter station name'
    station = gets.chomp 
    @route.del_station(route, station)
  end
end
