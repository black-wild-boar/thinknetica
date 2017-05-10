
class MenuRoute

  def m_routes
    puts "\nRoutes (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add station\n5. Remove station\nEnter exit to escape"
    @choice =
      { '1' => proc { m_add_route }, '2' => proc { m_remove_route },
        '3' => proc { m_routes_list }, '4' => proc { m_route_add_station },
        '5' => proc { m_route_remove_station }, 'exit' => proc { main_menu } }
  end

  def m_add_route
    p 'Enter route name'
    route = gets.chomp
    p 'Enter first station name'
    first = gets.chomp
    p 'Enter last station name'
    last = gets.chomp
    @routes[route] = Route.new(first, last) if @stations.key?(first && last)
  end

  def m_remove_route
    p 'Enter route name'
    route = gets.chomp
    if !@routes.key?(route)
      p 'Wrong route!'
    else
      @routes.delete(route)
    end
  end

  def m_routes_list
    puts "List of routes #{@routes}"
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
