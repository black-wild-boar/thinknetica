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

  @@trains    = {}


  def initialize
    @stations  = {}
    @routes    = {}
    #@trains    = {}
    @carriages = {}
  end

  def menu_intro
    puts "\nWelcome to railway station system! (choose menu number)"
    puts "1. Stations\n2. Routes\n3. Trains\nEnter exit to escape"
    @choice =
      { '1' => proc { stations_menu }, '2' => proc { routes_menu },
        '3' => proc { menu_train = MenuTrain.new }, 'exit' => proc { puts 'Bye!' } }
      # { '1' => proc { stations_menu }, '2' => proc { routes_menu },
      #   '3' => proc { trains_menu }, 'exit' => proc { puts 'Bye!' } }
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
      p 'Enter station name'
      station = gets.chomp
      station = Station.new(station)
    rescue => e
      puts e.inspect
      retry
    end
    @stations[station.name] = station
  end

  def m_remove_station
    p 'Enter station name'
    station = gets.chomp
    if @stations.key?(station)
      @stations.delete(station)
    else
      p 'No station'
    end
  end

  def m_staions_list
    puts @stations
  end

  def m_add_train_to_station(station)
    p 'Enter station name'
    station = gets.chomp
    @stations[station].each_train do |train|
      puts "Train N #{train.number}, type: #{train.class},'/
      'carriage count: #{train.carriages.length}"
    end
  end

  def m_train_on_station
    if @stations[station].nil? || @stations[station].train.empty?
      p 'No train on station'
    else
      m_add_train_to_station(station)
    end
  end

  def stations_menu
    m_stations
    @choice[gets.chomp].call
  end

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
  # ??? questions
  # how create dynamic hash filling by case of range key/value 
end # Menu

class MenuTrain
  
  attr_accessor :train, :carriage

    menu_train.trains_menu
  end

  def m_trains
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show trains on station\n11. Show all carriage"
    puts "12. Employ/release carriage space\nEnter exit to escape"
  end

  def m_add_train_type(train)
    self
    puts @@trains
    p '123'
    if @@trains.key?(train)
      p 'Train exist'
      p '321'
    else
      puts '1.Cargo/2.Passenger'
      train_type =
        { '1' => proc { CargoTrain.new(train) },
          '2' => proc { PassengerTrain.new(train) } }
      @trains[train] = train_type[gets.chomp].call
    end
  end

  def m_add_train
    begin
      p 'Enter train name'
      train = gets.chomp
      Train.new(train)
    rescue => e
      puts e.inspect
      retry
    end
    m_add_train_type(train)
  end

  def m_remove_train
    p 'Enter train name'
    train = gets.chomp
    if @trains.key?(train)
      @trains.delete(train)
    else
      p 'Wrong train!'
    end
  end

  def m_trains_list
    p "List of trains #{@trains}"
  end

  def m_train_add_route
    p 'Enter train'
    train = gets.chomp
    p "List of routes #{@routes}"
    p 'Enter route name'
    route = gets.chomp
    if @trains.key?(train) && @routes.key?(route)
      @trains[train].add_route(@routes[route])
    end
  end

  # to cut main class by separate train/station/wagon/route classes
  # bug with exit
  def choose_w_type(train, carriage)
    p 'Enter count'
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
      p 'Enter train name'
      train = gets.chomp
      p 'Enter carriage name'
      carriage = gets.chomp
      Carriage.new(carriage)
    rescue => e
      puts e.inspect
      retry
    end
    choose_w_type(train, carriage)
  end

  def m_check_train_key(train)
    p 'Wrong train!' if @trains.key?(train)
  end

  def m_remove_wagon
    p 'Enter train name'
    train = gets.chomp
    p 'Enter carriage name'
    carriage = gets.chomp
    if @trains.key?(train)
    elsif @trains[train].carriage_include?(@carriages[carriage])
      @trains[train].del_carriage(@carriages[carriage])
    else
      p 'Wrong train or carriage!'
    end
  end

  def m_current_station
    p 'Enter train name'
    train = gets.chomp
    p 'Enter station name'
    station = gets.chomp
    if @trains.key?(train) && @stations.key?(station)
      @trains[train].go_current_station(station)
      @stations[station].add_train(@trains[train])
    else
      p 'Wrong train or station!'
    end
  end

  def m_next_station
    p 'Enter train name'
    train = gets.chomp
    @trains[train].next_station
  end

  def m_prev_station
    p 'Enter train name'
    train = gets.chomp
    @trains[train].prev_station
  end

  def m_trains_on_station
    puts "List of trains #{@trains}"
    p 'Enter station name'
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
    p 'Enter train name'
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
    # def m_wagon_volume(enter_train, check_carriage_name)
    p '1.Employ/2.Release'
    choose = gets.chomp.to_s
    p 'Enter count'
    volume = gets.chomp.to_i
    employ_choice = {
      '1' => proc { wagon_employ(train, carriage, volume) },
      '2' => proc { wagon_release(train, carriage, volume) }
    }
    employ_choice[choose].call
  end

  def local_occupie_volume; end

  # or cut with methods
  def wagon_employ(train, carriage, volume)
    # @trains[train].carriages[carriage].
    wagon_employ =
#      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].occupie_seat },
#        'CargoTrain' => proc { @trains[train].carriages[carriage].occupie_volume(volume) } }
      { 'PassengerTrain' => cargo_wagon_employ(train, carriage, volume),
        'CargoTrain' => passenger_wagon_employ(train, carriage, volume) }
    wagon_employ[@trains[enter_train].class.to_s].call
  end
# not working
  def cargo_wagon_employ(train, carriage, volume)
    @trains[train].carriages[carriage].occupie_seat
  end

  def passenger_wagon_employ(train, carriage, volume)
    @trains[train].carriages[carriage].occupie_volume(volume)
  end

  def wagon_release(train, carriage, volume)
    wagon_release =
      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].release_seat },
        'CargoTrain' => proc { @trains[train].carriages[carriage].release_volume(volume) } }
    wagon_release[@trains[train].class.to_s].call
  end

  def enter_train
    p 'Enter train name'
    gets.chomp
  end

  def enter_carriage
    p 'Enter carriage name'
    gets.chomp
  end

  def check_carriage_name
    Carriage.new(enter_carriage)
  rescue => e
    puts e.inspect
    retry
  end

  def m_wagon_space
    # puts enter_train
    # puts enter_carriage
    # begin
    #   Carriage.new(carriage)
    # rescue => e
    #   puts e.inspect
    #   retry
    # end
    # check_carriage_name
    train = enter_train
    carriage = check_carriage_name
    puts train
    puts carriage
    m_wagon_volume(train, carriage)
  end

  # cut method
  def trains_menu
    p "trains_menu"
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
end # TrainMenu


class MenuStations
  #  attr_accessor :station
end

class MenuRoutes
end

railway = Menu.new

railway.main_menu
