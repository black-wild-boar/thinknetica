require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Menu
  attr_accessor :stations, :routes, :trains, :carriages, :choice

  def initialize
    @stations  = {}
    @routes    = {}
    @trains    = {}
    @carriages = {}
  end

  def menu_intro
    puts "\nWelcome to railway station system! (choose menu number)"
    puts "1. Stations\n2. Routes\n3. Trains\nEnter exit to escape"
    @choice =
      { '1' => proc { stations_menu }, '2' => proc { routes_menu },
        '3' => proc { trains_menu }, 'exit' => proc { puts 'Bye!' } }
  end

  def main_menu
    menu_intro
    @choice[gets.chomp].call
  end

  def m_stations
    puts "\nStations (choose menu number)"
    puts "1. Add\n2. Remove\n3. Show all"
    puts "4. Show all train on station\nEnter exit to escape"
    @choice =
      { '1' => proc { m_add_station }, '2' => proc { m_remove_station },
        '3' => proc { m_staions_list }, '4' => proc { m_train_on_station },
        'exit' => proc { main_menu } }
  end

  def m_add_station
    begin
      puts 'Enter station name'
      station = gets.chomp
      station = Station.new(station)
    rescue => e
      puts e.inspect
      retry
    end
    @stations[station.name] = station
  end

  def m_remove_station
    puts 'Enter station name'
    station = gets.chomp
    if @stations.key?(station)
      @stations.delete(station)
    else
      puts 'No station'
    end
  end

  def m_staions_list
    puts @stations
  end

  def m_add_train_to_station(station)
    puts 'Enter station name'
    station = gets.chomp
    @stations[station].each_train do |train|
      puts "Train N #{train.number}, type: #{train.class},'/
      'carriage count: #{train.carriages.length}"
    end
  end

  def m_train_on_station
    if @stations[station].nil? || @stations[station].train.empty?
      puts 'No train on station'
    else
      m_add_train_to_station(station)
    end
  end

  def stations_menu
    m_stations
    @choice[gets.chomp].call
  end

  def m_routes
    puts "\nRoutes (choose menu number)"
    puts "1. Add\n2. Remove\n3. Show all\n4. Add station"
    puts "5. Remove station\nEnter exit to escape"
    @choice =
      { '1' => proc { m_add_route }, '2' => proc { m_remove_route },
        '3' => proc { m_routes_list }, '4' => proc { m_route_add_station },
        '5' => proc { m_route_remove_station }, 'exit' => proc { main_menu } }
  end

  def m_add_route_check; end

  def m_add_route
    puts 'Enter route name'
    route = gets.chomp
    puts 'Enter first station name'
    first = gets.chomp
    puts 'Enter last station name'
    last = gets.chomp
    @routes[route] = Route.new(first, last) if @stations.key?(first && last)
  end

  def m_remove_route
    puts 'Enter route name'
    route = gets.chomp
    if !@routes.key?(route)
      puts 'Wrong route!'
    else
      @routes.delete(route)
    end
  end

  def m_routes_list
    puts "List of routes #{@routes}"
  end

  def m_route_add_station
    puts 'Enter route name'
    route = gets.chomp
    puts 'Enter station name'
    station = gets.chomp
    if @routes.key?(route) && @stations.key?(station)
      @routes[route].add_station(station)
    else
      puts 'Wrong route or station'
    end
  end

  def m_route_remove_station
    puts 'Enter route name'
    route = gets.chomp
    puts 'Enter station name'
    station = gets.chomp
    if @routes.include?(route) && @routes[route].stations.include?(station)
      @routes[route].del_station(station)
    else
      puts 'Wrong route or station'
    end
  end

  def routes_menu
    m_routes
    @choice[gets.chomp].call
  end
  # ??? как вариант
  # динамический хэш наполнение по условию
  # есть общий хэш, в зависимости от условия выводится определенный диапазон ключей/значений

  def m_trains_wagons; end

  def m_trains
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show trains on station\n11. Show all carriage"
    puts "12. Employ/release carriage space\nEnter exit to escape"
  end

  def m_add_train_type(train)
    if @trains.key?(train)
      puts 'Train exist'
    else
      puts 'Cargo (enter 1), passenger (enter 2)'
      train_type = { '1' => proc { CargoTrain.new(train) }, '2' => proc { PassengerTrain.new(train) } }
      @trains[train] = train_type[gets.chomp].call
    end
  end

  def m_add_train
    begin
      puts 'Enter train name'
      train = gets.chomp
      Train.new(train)
    rescue => e
      puts e.inspect
      retry
    end
    m_add_train_type(train)
  end

  def m_remove_train
    puts 'Enter train name'
    train = gets.chomp
    if @trains.key?(train)
      @trains.delete(train)
    else
      puts 'Wrong train!'
    end
  end

  def m_trains_list
    puts "List of trains #{@trains}"
  end

  def m_train_add_route
    puts 'Enter train'
    train = gets.chomp
    puts "List of routes #{@routes}"
    puts 'Enter route name'
    route = gets.chomp
    if @trains.key?(train) && @routes.key?(route)
      @trains[train].add_route(@routes[route])
    end
  end

  # явно нужно разделить поезда/вагоны/станции/маршруты по отдельным классам
  # трабл с exit
  def choose_w_type(train, carriage)
    puts 'Enter count'
    count = gets.chomp.to_i
    choose_w_type2(train, carriage, count) if @trains[train]
  end

  def choose_w_type2(train, carriage, count)
    wagon_types =
      { 'PassengerTrain' => proc { PassengerCarriage.new(carriage, count) },
        'CargoTrain' => proc { CargoCarriage.new(carriage, count) } }
    @carriages[carriage] = wagon_types[@trains[train].class.to_s].call
    @trains[train].add_carriage(@carriages[carriage])
  end

  def m_add_wagon
    begin
      puts 'Enter train name'
      train = gets.chomp
      puts 'Enter carriage name'
      carriage = gets.chomp
      Carriage.new(carriage)
    rescue => e
      puts e.inspect
      retry
    end
    choose_w_type(train, carriage)
  end

  def m_check_train_key(train)
    puts 'Wrong train!' if @trains.key?(train)
  end

  def m_remove_wagon
    puts 'Enter train name'
    train = gets.chomp
    puts 'Enter carriage name'
    carriage = gets.chomp
    if @trains.key?(train)
    elsif @trains[train].carriage_include?(@carriages[carriage])
      @trains[train].del_carriage(@carriages[carriage])
    else
      puts 'Wrong train or carriage!'
    end
  end

  def m_current_station
    puts 'Enter train name'
    train = gets.chomp
    puts 'Enter station name'
    station = gets.chomp
    if @trains.key?(train) && @stations.key?(station)
      @trains[train].go_current_station(station)
      @stations[station].add_train(@trains[train])
    else
      puts 'Wrong train or station!'
    end
  end

  def m_next_station
    puts 'Enter train name'
    train = gets.chomp
    @trains[train].next_station
  end

  def m_prev_station
    puts 'Enter train name'
    train = gets.chomp
    @trains[train].prev_station
  end

  def m_trains_on_station
    puts "List of trains #{@trains}"
    puts 'Enter station name'
    station = gets.chomp
    @trains.select do |name, value|
      puts "#{name} : #{value}" if value.current_station_id == station
    end
  end

  def m_cargo_free_engaged(wagon)
    p "Carriage N #{wagon.number}, "\
      "type: #{wagon.class}, " \
      "free space: #{wagon.free_volume}, "\
      "engaged volume: #{wagon.engaged_volume}"
  end

  def m_passenger_free_engaged(wagon)
    p "Carriage N #{wagon.number}, "\
      "type: #{wagon.class}, "\
      "free seats: #{wagon.seats_free}, "\
      "engaged seats: #{wagon.seats_engaged}"
  end

  def m_carriages_list
    puts 'Enter train name'
    train = gets.chomp
    @trains[train].each_carriage do |wagon|
      case wagon.class.to_s
      when 'PassengerCarriage' then m_passenger_free_engaged(wagon)
      when 'CargoCarriage' then m_cargo_free_engaged(wagon)
      else
        puts 'Untyped carriage'
      end
    end
  end

  def m_wagon_volume(train, carriage)
    puts '1.Employ/2.Release'
    choose = gets.chomp.to_s
    puts 'Enter count'
    volume = gets.chomp.to_i
    employ_choice = {
      '1' => proc { wagon_employ(train, carriage, volume) },
      '2' => proc { wagon_release(train, carriage, volume) }
    }
    employ_choice[choose].call
  end

  def local_occupie_volume
  end
# или разделить на методы по классам
  def wagon_employ(train, carriage, volume)
    wagon_employ =
      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].occupie_seat },
        'CargoTrain' => proc { @trains[train].carriages[carriage].occupie_volume(volume) } }
    wagon_employ[@trains[train].class.to_s].call
  end

  def wagon_release(train, carriage, volume)
    wagon_release =
      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].release_seat },
        'CargoTrain' => proc { @trains[train].carriages[carriage].release_volume(volume) } }
    wagon_release[@trains[train].class.to_s].call
  end

  def check_carriage_name
    puts 'Enter carriage name'
    carriage = gets.chomp
    Carriage.new(carriage)
  rescue => e
    puts e.inspect
    retry
  end

  def m_wagon_space
    begin
      puts 'Enter train name'
      train = gets.chomp
      puts 'Enter carriage name'
      carriage = gets.chomp
      Carriage.new(carriage)
    rescue => e
      puts e.inspect
      retry
    end
    m_wagon_volume(train, carriage)
  end

  # вынести метод меню с передачей значение == методу (разбить по подпунктам)
  def trains_menu
    loop do
      m_trains
      t_choice =
        { '1' => proc { m_add_train }, '2' => proc { m_remove_train },
          '3' => proc { m_trains_list }, '4' => proc { m_train_add_route },
          '5' => proc { m_add_wagon }, '6' => proc { m_remove_wagon },
          '7' => proc { m_current_station }, '8' => proc { m_next_station },
          '9' => proc { m_prev_station }, '10' => proc { m_trains_on_station },
          '11' => proc { m_carriages_list }, '12' => proc { m_wagon_space },
          'exit' => proc { main_menu } }
      t_choice[gets.chomp].call
    end
  end
end

railway = Menu.new

railway.main_menu
