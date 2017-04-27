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

  def menu_stations
    puts "\n"
    puts 'Stations (choose menu number)'
    puts '1. Add'
    puts '2. Remove'
    puts '3. Show all'
    puts '4. Show all train on station'
    puts 'Enter exit to escape'
    @choice = gets.chomp
  end

  def add_station
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

  def remove_station
    puts 'Enter station name'
    station = gets.chomp
    if @stations.key?(station)
      @stations.delete(station)
    else
      puts 'No station'
    end
  end

  def staions_list
    puts @stations
  end

  def train_on_station
    if @stations[station].nil? || @stations[station].train.empty?
      puts 'No train on station'
    else
      puts 'Enter station name'
      station = gets.chomp
      @stations[station].each_train do |train|
        puts "Train N #{train.number}, type: #{train.class},'/
        'carriage count: #{train.carriages.length}"
      end
    end
  end

  def stations_menu
    loop do
      menu_stations
      choices = { '1' => proc { add_station },
                  '2' =>  proc { remove_station },
                  '3' =>  proc { staions_list },
                  '4' =>  proc { train_on_station } }
      break if @choice == 'exit'
      choices[@choice].call
    end
  end

  def menu_routes
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

  def routes_menu
    loop do
      menu_routes
      break if @choice == 'exit'
      case @choice
      when '1'
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
      when '2'
        puts 'Enter route name'
        route = gets.chomp
        if !@routes.key?(route)
          puts 'Wrong route!'
        else
          @routes.delete(route)
        end
      when '3'
        puts "List of routes #{@routes}"
      when '4'
        puts 'Enter route name'
        route = gets.chomp
        puts 'Enter station name'
        station = gets.chomp
        if @routes.key?(route) && @stations.key?(station)
          @routes[route].add_station(station)
        else
          puts 'Wrong route or station'
        end
      when '5'
        puts 'Enter route name'
        route = gets.chomp
        puts 'Enter station name'
        station = gets.chomp
        if @routes.include?(route) && @routes[route].stations.include?(station)
          @routes[route].del_station(station)
        else
          puts 'Wrong route or station'
        end
      else
        puts 'Wrong choice!'
      end
    end
  end

  def menu_trains
    puts "\n"
    puts 'Trains (choose menu number)'
    puts '1. Add'
    puts '2. Remove'
    puts '3. Show all'
    puts '4. Add route'
    puts '5. Add carriage'
    puts '6. Remove carriage'
    puts '7. Set current station'
    puts '8. Next station'
    puts '9. Prev station'
    puts '10. Show trains on station'
    puts '11. Show all carriage'
    puts '12. Employ/release carriage space'
    puts 'Enter exit to escape'
    @choice = gets.chomp
  end

  def trains_menu
    loop do
      menu_trains
      break if @choice == 'exit'
      case @choice
      when '1'
        begin
          puts 'Enter train name'
          train = gets.chomp
          Train.new(train)
        rescue => e
          puts e.inspect
          retry
        end
        puts 'Cargo (enter 1), passenger (enter 2)'
        train_type = gets.chomp

        case train_type.to_i
        when 1
          if !@trains.key?(train)
            @trains[train] = CargoTrain.new(train)
          else
            puts 'Train exist'
          end
        when 2
          if !@trains.key?(train)
            @trains[train] = PassengerTrain.new(train)
          else
            puts 'Train exist'
          end
        else
          puts 'Wrong choice!'
        end
      when '2'
        puts 'Enter train name'
        train = gets.chomp
        if @trains.key?(train)
          @trains.delete(train)
        else
          puts 'Wrong train!'
        end
      when '3'
        puts "List of trains #{@trains}"
      when '4'
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
      when '5'
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
      when '6'
        puts @trains
        puts 'Enter train name'
        train = gets.chomp
        puts 'Enter carriage name'
        carriage = gets.chomp
        if @trains.key?(train) && @trains[train].carriage_include?(@carriages[carriage])
          @trains[train].del_carriage(@carriages[carriage])
        else
          puts 'Wrong train or carriage!'
        end
      when '7'
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
      when '8'
        puts 'Enter train name'
        train = gets.chomp
        @trains[train].next_station
      when '9'
        puts 'Enter train name'
        train = gets.chomp
        @trains[train].prev_station
      when '10'
        puts "List of trains #{@trains}"
        puts 'Enter station name'
        station = gets.chomp
        @trains.select do |name, value|
          puts "#{name} : #{value}" if value.current_station_id == station
        end
      when '11'
        puts 'Enter train name'
        train = gets.chomp
        @trains[train].each_carriage do |wagon|
          if wagon.is_a?(CargoCarriage)
            puts "Carriage N #{wagon.number}, type: #{wagon.class}, " \
                  "free space: #{wagon.free_volume}, "\
                  " engaged volume: #{wagon.engaged_volume}"
          elsif wagon.is_a?(PassengerCarriage)
            puts "Carriage N #{wagon.number}, type: #{wagon.class}, "\
                  "free seats: #{wagon.seats_free}, "\
                  "engaged seats: #{wagon.seats_engaged}"
          else
            puts 'Untyped carriage'
          end
        end
      when '12'
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
      else
        puts 'Wrong choice'
      end
    end
  end
end

railway = Menu.new

railway.main_menu
