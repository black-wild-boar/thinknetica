require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Menu

attr_accessor :all_stations, :all_routes, :all_trains, :all_carriages
  
  def initialize
    @all_stations  = {}
    @all_routes    = {}
    @all_trains    = {}
    @all_carriages = {}
  end

  def main_menu
    key = ''

    while key != 'exit' do
      puts "\n"
      puts "Welcome to railway station system! (choose menu number)"
      puts "\n"
      puts "1. Stations"
      puts "2. Routes"
      puts "3. Trains"
      puts "Enter exit to escape"
      key = gets.chomp

      break if key == 'exit'

      case key.to_i 
      when 1
        stations_menu
      when 2
        routes_menu
      when 3
        trains_menu
      else 
        puts "Wrong choice!"  
      end
    end
  end

  def stations_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Stations (choose menu number)"
      puts "1. Add"
      puts "2. Remove"
      puts "3. Show all"
      puts "4. Show all train on station"
      puts "Enter exit to escape"
      key = gets.chomp
      case key.to_i 
      when 1
        begin
          puts "Enter station name"
          station_name = gets.chomp
          station = Station.new(station_name)
        rescue => e
          puts e.inspect
          retry
        end  
        @all_stations[station.name] = station
      when 2
        puts "Enter station name"
        station_name = gets.chomp
        if @all_stations.keys.include?(station_name)
          @all_stations.delete(station_name)
        else
          puts "No station"
        end
      when 3
        puts "Station of stations #{@all_stations}"
      when 4
        if @all_stations[station_name].nil? || @all_stations[station_name].train.empty?
          puts "No train on station"
        else
          puts "Enter station name"
          station_name = gets.chomp
          @all_stations[station_name].each_train { |train| puts "Train N #{train.number}, type: #{train.class}, carriage count: #{train.carriages.length}"}
        end
      else 
        puts "Wrong station!"
      end
    end
  end

  def routes_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Routes (choose menu number)"
      puts "1. Add"
      puts "2. Remove"
      puts "3. Show all"
      puts "4. Add station"
      puts "5. Remove station"
      puts "Enter exit to escape"
      key = gets.chomp
      case key.to_i 
      when 1
        puts "Enter route name"
        route_name = gets.chomp
        puts "List of stations #{@all_stations}"
        puts "Enter first station name"
        station_first = gets.chomp
        puts "Enter last station name"
        station_last = gets.chomp
        if @all_stations.keys.include?(station_first) && @all_stations.keys.include?(station_last) && !@all_routes.include?(route_name)
          @all_routes[route_name] = Route.new(station_first,station_last)
        else
          puts "Wrong route or station"
        end        
        
      when 2
        puts "Enter route name"
        route_name = gets.chomp
        if !@all_routes.keys.include?(route_name)
          puts "Wrong route!"
        else
          @all_routes.delete(route_name)
        end
      when 3
        puts "List of routes #{@all_routes}"
      when 4
        puts "Enter route name"
        route_name = gets.chomp
        puts "Enter station name"
        station_name = gets.chomp
        if @all_routes.keys.include?(route_name) && @all_stations.keys.include?(station_name)
          @all_routes[route_name].add_station(station_name)
        else
          puts "Wrong route or station"
        end
      when 5
        puts "Enter route name"
        route_name = gets.chomp
        puts "Enter station name"
        station_name = gets.chomp
        if @all_routes.include?(route_name) && @all_routes[route_name].stations.include?(station_name)
          @all_routes[route_name].del_station(station_name)
        else
          puts "Wrong route or station"
        end
      else 
        puts "Wrong choice!"  
      end
    end
  end

  def trains_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Trains (choose menu number)"
      puts "1. Add"
      puts "2. Remove"
      puts "3. Show all"
      puts "4. Add route"
      puts "5. Add carriage"
      puts "6. Remove carriage"
      puts "7. Set current station"
      puts "8. Next station"
      puts "9. Prev station"
      puts "10. Show trains on station"
      puts "11. Show all carriage"
      puts "12. Employ/release carriage space"
      puts "Enter exit to escape"
      key = gets.chomp

      case key.to_i 
      when 1
        begin
        puts "Enter train name"
        train_name = gets.chomp
        Train.new(train_name)
        rescue => e
          puts e.inspect
          retry
        end  
        puts "Cargo (enter 1), passenger (enter 2)"
        train_type = gets.chomp
        
        case train_type.to_i
        when 1
          if !@all_trains.keys.include?(train_name)
            @all_trains[train_name] = CargoTrain.new(train_name)
          else
            puts "Train exist"
          end
        when 2
          if !@all_trains.keys.include?(train_name)
            @all_trains[train_name] = PassengerTrain.new(train_name)
          else
            puts "Train exist"
          end
        else
          puts "Wrong choice!"
        end
      when 2
        puts "Enter train name"
        train_name = gets.chomp
        if @all_trains.keys.include?(train_name)
          @all_trains.delete(train_name)
        else
          puts "Wrong train!"
        end
      when 3
        puts "List of trains #{@all_trains}"
      when 4
        puts "Enter train_name"
        train_name  = gets.chomp
        puts "List of routes #{@all_routes}"
        puts "Enter route name"
        route_name  = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_routes.keys.include?(route_name)
          @all_trains[train_name].add_route(@all_routes[route_name])
        else
          puts "Wrong train or route!"
        end
      when 5
        begin
          puts "Enter train name"
          train_name  = gets.chomp
          puts "Enter carriage name"
          carriage_name = gets.chomp
          Carriage.new(carriage_name)
        rescue => e
          puts e.inspect
          retry
        end  
        if @all_trains[train_name] && @all_trains[train_name].is_a?(PassengerTrain)
          puts "Enter seats count"
          seats_count = gets.chomp.to_i
          @all_carriages[carriage_name] = PassengerCarriage.new(carriage_name, seats_count)
          @all_trains[train_name].add_carriage(@all_carriages[carriage_name])
        elsif @all_trains[train_name] && @all_trains[train_name].is_a?(CargoTrain)
          puts "Enter volume"
          carriage_volume = gets.chomp.to_i
          @all_carriages[carriage_name] = CargoCarriage.new(carriage_name, carriage_volume)
          @all_trains[train_name].add_carriage(@all_carriages[carriage_name])
        else
          puts "Wrong train!"
        end
      when 6
        puts @all_trains
        puts "Enter train name"
        train_name  = gets.chomp
        puts "Enter carriage name"
        carriage_name = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_trains[train_name].carriage_include?(@all_carriages[carriage_name])
          @all_trains[train_name].del_carriage(@all_carriages[carriage_name])
        else
          puts "Wrong train or carriage!"
        end
      when 7
        puts "Enter train name"
        train_name  = gets.chomp
        puts "Enter station name"
        station_name  = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_stations.keys.include?(station_name)
          @all_trains[train_name].set_current_station(station_name)
          @all_stations[station_name].add_train(@all_trains[train_name])
        else
          puts "Wrong train or station!"
        end
      when 8
        puts "Enter train name"
        train_name  = gets.chomp
        @all_trains[train_name].next_station
      when 9
        puts "Enter train name"
        train_name  = gets.chomp
        @all_trains[train_name].prev_station
      when 10
        puts "List of trains #{@all_trains}"
        puts "Enter station name"
        station_name = gets.chomp
        @all_trains.select { |key, value| puts "#{key} : #{value}" if value.current_station_id == station_name}
      when 11
        puts "Enter train name"
        train_name  = gets.chomp
        @all_trains[train_name].each_carriage do |carriage| 
          if carriage.is_a?(CargoCarriage)
            puts "Carriage N #{carriage.number}, type: #{carriage.class}, free space: #{carriage.free_volume}, engaged volume: #{carriage.engaged_volume}"
          elsif carriage.is_a?(PassengerCarriage)
            puts "Carriage N #{carriage.number}, type: #{carriage.class}, free seats: #{carriage.seats_free}, engaged seats: #{carriage.seats_engaged}"
          else
            puts "Untyped carriage"
          end
        end
      when 12
        begin
          puts "List of trains #{@all_trains}"
          puts "Enter train name"
          train_name  = gets.chomp
          puts "Enter carriage name"
          carriage_name = gets.chomp
          Carriage.new(carriage_name)
        rescue => e
          puts e.inspect
          retry
        end  
          puts "Employ. Enter 1"
          puts "Release. Enter 2"
          choice = gets.chomp.to_i
          case choice
          when 1
            if @all_trains[train_name] && @all_trains[train_name].is_a?(PassengerTrain)
              @all_trains[train_name].carriages[carriage_name].occupie_seat
            elsif @all_trains[train_name] && @all_trains[train_name].is_a?(CargoTrain)
              puts "Enter count"
              volume = gets.chomp.to_i
              @all_trains[train_name].carriages[carriage_name].occupie_volume(volume)
            else
              puts "Untyped carriage"
            end
          when 2
            if @all_trains[train_name] && @all_trains[train_name].is_a?(PassengerTrain)
              @all_trains[train_name].carriages[carriage_name].release_seat
            elsif @all_trains[train_name] && @all_trains[train_name].is_a?(CargoTrain)
              puts "Enter count"
              volume = gets.chomp.to_i
              @all_trains[train_name].carriages[carriage_name].release_volume(volume)
            else
              puts "Untyped carriage"
            end
          else
            puts "Wrong choice!"
          end
      else 
        puts "Wrong choice" 
      end
    end
  end
end

railway = Menu.new

railway.main_menu
