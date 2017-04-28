require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Menu
  # TRAIN_TYPES = { '1': 'CargoTrain', '2': 'PassengerTrain'}
  # WAGON_TYPES = { '1': 'CargoCarriage', '2': 'PassengerCarriage'}

  attr_accessor :stations, :routes, :trains, :carriages, :choice

  def initialize
    @stations  = {}
    @routes    = {}
    @trains    = {}
    @carriages = {}
  end

  def menu_intro
    puts "\n"
    puts 'Welcome to railway station system! (choose menu number)'
    puts "\n"
    puts '1. Stations'
    puts '2. Routes'
    puts '3. Trains'
    puts 'Enter exit to escape'
    @choice = gets.chomp
  end

  def main_menu
    loop do
      menu_intro
      break if @choice == 'exit'
      case @choice
      when '1' then stations_menu
      when '2' then routes_menu
      when '3' then trains_menu
      else
        puts 'Wrong choice!'
      end
      @choice = ''
    end
  end

  def m_stations
    puts "\n"
    puts 'Stations (choose menu number)'
    puts '1. Add'
    puts '2. Remove'
    puts '3. Show all'
    puts '4. Show all train on station'
    puts 'Enter exit to escape'
    @choice = gets.chomp
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
    loop do
      m_stations
      choices = { '1' => proc { m_add_station },
                  '2' => proc { m_remove_station },
                  '3' => proc { m_staions_list },
                  '4' => proc { m_train_on_station } }
      break if @choice == 'exit'
      if choices[@choice].nil?
        puts 'Wrong choice!'
      else
        choices[@choice].call
      end
    end
  end

  def m_routes
    puts "\n"
    puts 'Routes (choose menu number)'
    puts '1. Add'
    puts '2. Remove'
    puts '3. Show all'
    puts '4. Add station'
    puts '5. Remove station'
    puts 'Enter exit to escape'
    @choice = gets.chomp
  end

  def m_add_route_check; end

  def m_add_route
    puts 'Enter route name'
    route = gets.chomp
    puts "List of stations #{@stations}"
    puts 'Enter first station name'
    first = gets.chomp
    puts 'Enter last station name'
    last = gets.chomp
    if !@routes.include?(route) && @stations.key?(first && last)
      @routes[route] = Route.new(first, last)
    else
      puts 'Wrong route or station'
    end
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
    loop do
      m_routes
      choices = { '1' => proc { m_add_route },
                  '2' => proc { m_remove_route },
                  '3' => proc { m_routes_list },
                  '4' => proc { m_route_add_station },
                  '5' => proc { m_route_remove_station } }
      break if @choice == 'exit'
      if choices[@choice].nil?
        puts 'Wrong choice!'
      else
        choices[@choice].call
      end
    end
  end

#динамический хэш наполнение по условию
#есть общий хэш, в зависимости от условия выводится определенный диапазон ключей/значений
TRAIN_MENU = {}

  def m_trains_stations
    puts '4. Add route'
    puts '5. Add carriage'
    puts '6. Remove carriage'
    puts '7. Set current station'
    puts '8. Next station'
    puts '9. Prev station'
    puts '10. Show trains on station'
    puts '11. Show all carriage'
    puts '12. Employ/release carriage space'
  end

  def m_trains_wagons
  end

  def m_trains
    puts "\n"
    puts 'Trains (choose menu number)'
    puts '1. Add'
    puts '2. Remove'
    puts '3. Show all'
    puts 'Enter exit to escape'
    @choice = gets.chomp
  end



  def m_add_train_type(train)
    puts 'Cargo (enter 1), passenger (enter 2)'
    train_type = gets.chomp
    trains[train] = case train_type
                    when '1' then CargoTrain.new(train)
                    when '2' then PassengerTrain.new(train)
                    else puts 'Untyped'
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
    @trains.key?(train) ? (p 'Train exist') : m_add_train_type(train)
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
    else
      puts 'Wrong train or route!'
    end
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
    if @trains[train] && @trains[train].is_a?(PassengerTrain)
      puts 'Enter seats count'
      seats_count = gets.chomp.to_i
      @carriages[carriage] = PassengerCarriage.new(carriage, seats_count)
      @trains[train].add_carriage(@carriages[carriage])
    elsif @trains[train] && @trains[train].is_a?(CargoTrain)
      puts 'Enter volume'
      carriage_volume = gets.chomp.to_i
      @carriages[carriage] = CargoCarriage.new(carriage, carriage_volume)
      @trains[train].add_carriage(@carriages[carriage])
    else
      puts 'Wrong train!'
    end
  end

  # вынести @trains.key?(train) puts "Train not exist"
  # CONST
  def m_remove_wagon
    puts @trains
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
      @trains[train].set_current_station(station)
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
      puts = case wagon.class.to_s
             when 'PassengerCarriage' then m_passenger_free_engaged(wagon)
             when 'CargoCarriage' then m_cargo_free_engaged(wagon)
             else
               puts 'Untyped carriage'
      end
    end
  end

  def m_wagon_space
    begin
      puts "List of trains #{@trains}"
      puts 'Enter train name'
      train = gets.chomp
      puts 'Enter carriage name'
      carriage = gets.chomp
      Carriage.new(carriage)
    rescue => e
      puts e.inspect
      retry
    end
    puts 'Employ. Enter 1'
    puts 'Release. Enter 2'
    choice = gets.chomp.to_i
    case choice
    when 1
      if @trains[train] && @trains[train].is_a?(PassengerTrain)
        @trains[train].carriages[carriage].occupie_seat
      elsif @trains[train] && @trains[train].is_a?(CargoTrain)
        puts 'Enter count'
        volume = gets.chomp.to_i
        @trains[train].carriages[carriage].occupie_volume(volume)
      else
        puts 'Untyped carriage'
      end
    when 2
      if @trains[train] && @trains[train].is_a?(PassengerTrain)
        @trains[train].carriages[carriage].release_seat
      elsif @trains[train] && @trains[train].is_a?(CargoTrain)
        puts 'Enter count'
        volume = gets.chomp.to_i
        @trains[train].carriages[carriage].release_volume(volume)
      else
        puts 'Untyped carriage'
      end
    else
      puts 'Wrong choice!'
    end
  end

  def trains_menu
    loop do
      m_trains
      choices = {
        '1' => proc { m_add_train }, '2' => proc { m_remove_train },
        '3' => proc { m_trains_list }, '4' => proc { m_train_add_route },
        '5' => proc { m_add_wagon }, '6' => proc { m_remove_wagon },
        '7' => proc { m_current_station }, '8' => proc { m_next_station },
        '9' => proc { m_prev_station }, '10' => proc { m_trains_on_station },
        '11' => proc { m_carriages_list }, '12' => proc { m_wagon_space }
                }
      break if @choice == 'exit'
      if choices[@choice].nil?
        puts 'Wrong choice!'
      else
        choices[@choice].call
      end
    end
  end
end

railway = Menu.new

railway.main_menu
