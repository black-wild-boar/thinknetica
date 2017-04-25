require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Menu
  attr_accessor :all_stations, :all_routes, :all_trains, :all_carriages, :action

def initialize
  @stations  = {}
  @routes    = {}
  @trains    = {}
  @carriages = {}
end

def menu_intro
  puts "\n"
  puts 'Рады приветствовать Вас на нашей трешовой станции!'
  puts "\n"
  puts 'Управление станциями. Жми 1'
  puts 'Управление маршрутами. Жми 2'
  puts 'Управление поездами. Жми 3'
  puts 'Enter "exit" for exit'
  gets.chomp
end

def menu_station
  puts "\n"
  puts 'Первый круг ада. Станции.'
  puts 'Добавить. Жми 1'
  puts 'Удалить. Жми 2'
  puts 'Покажи мне их. Жми 3'
  puts 'Узреть все поезда на станциях. Жми 4'
  puts 'Enter "exit" for exit'
  gets.chomp
end

def menu_route
  puts "\n"
  puts 'Второй круг ада. Маршруты.'
  puts 'Добавить. Жми 1'
  puts 'Удалить. Жми 2'
  puts 'Покажи мне их все. Жми 3'
  puts 'Добавить станцию радости. Жми 4'
  puts 'Уничтожить станцию ужаса. Жми 5'

  puts 'Enter "exit" for exit'
  gets.chomp
end

def menu_train
  puts "\n"
  puts 'Третий круг ада. Поезда.'
  puts 'Добавить. Жми 1'
  puts 'Удалить. Жми 2'
  puts 'Явитесь, поезда! Жми 3'
  puts 'Послать поезд по маршруту. Жми 4'
  puts 'Добавить вагон балласта. Жми 5'
  puts 'Уничтожить балласта вагон. Жми 6'
  puts 'Отправить поезд на станцию в даль. Жми 7'
  puts 'Перевести поезд на следующую станцию. Жми 8'
  puts 'Перевести поезд на предыдущую станцию. Жми 9'
  puts 'Поезда на станции. Жми 10'
  puts 'Все вагоны поездов. Жми 11'
  puts 'Занять/Освободить пространство вагона. Жми 12'
  puts 'Enter "exit" for exit'
  key = gets.chomp
end

def gets_station
  puts 'Enter station name'
  station = gets.chomp
end

def gets_route
  puts 'Enter route name'
  route = gets.chomp
end

def gets_carriage
  puts 'Enter carrige name'
  carriage = gets.chomp
end  

def gets_train
  puts 'Enter train name'
  train = gets.chomp
end

def main_menu
 # choice = ''

  choice ||= intro  

  while do choice# choice != 'exit' do
    if choice !='exit'
    #break if choice == 'exit'
    #intro
      #choice = case intro
      case intro
      when '1'
        stations_menu
      when '2'
        routes_menu
      when '3'
        trains_menu
      else
        puts 'Кто здесь?'
      end
    else
      break
    end
  end
end

def stations_menu

=begin  choice = ''
  while choice !='exit' do
    
    #unless 'exit' menu_station

    #choice = case @action
    case @action 
    when '1'
      begin
        station = Station.new(gets_station)
      rescue => e
        puts e.inspect
        retry
      end
      @stations[station.name] = station
    when '2'
      if @stations.keys.include?(gets_station)
        @stations.delete(station)
      else
        puts 'Нет такой станции. Вообще нет)'
      end
    when '3'
      puts "List of stations #{@stations}"
    when '4'
      station_object = gets_station
      @stations[station_object].each_train do |train|
        puts "Train N: #{train.number}, \
        type: #{train.class}, \
        carriage count: #{train.carriages.length}"
      end
    else
      puts 'Станции такого не умеют'
    end #case
  end #while
=end  #main_menu
end #def

def routes_menu

  key = ''
  while key != 'exit' do
    menu_route
    case key.to_i
    when 1
      gets_route
      puts "List of stations #{@stations}"
      puts 'Введи имя начала'
      first = gets.chomp
      puts 'Введи имя конца'
      last = gets.chomp

      if @stations.keys.include?(first)
        if @stations.keys.include?(last) && @routes.include?(route)
          @routes[route] = Route.new(first, last)
        else
          puts 'Нет станции такой или маршрут тоже... еcть'
        end
      end
    when 2
      gets_route
      if !@routes.keys.include?(route)
        puts 'Ты чего удалять-то пытаешься... нету его и не было никогда'
      else
        puts "Отправляйся в nil, маршрут #{route}"
        @routes.delete(route)
      end
    when 3
      puts "List of routes: #{@routes}"
    when 4
      puts 'Месть павших маршрутов. Добавление станции'
      gets_route
      gets_station
      if @routes.keys.include?(route) && @stations.keys.include?(station)
        @routes[route].add_station(station)
      else
        puts 'Нееееттт!!! Нет маршрута! Или есть уже такая станция'
      end
    when 5
      gets_route
      gets_station
      if @routes.include?(route) && @routes[route].stations.include?(station)
        @routes[route].del_station(station)
      else
        puts 'Не знаю таких'
      end
    else
      puts 'Станции такого не умеют'
    end
  end
end

def trains_menu

  key = ''
  while key != 'exit' do
    menu_train
    case key.to_i
    when 1
      begin
        gets_train
        puts 'Грузовой (нажми 1), Пассажирский (нажми 2)'
        train_type = gets.chomp
  
        Train.new(train)
        rescue => e
          puts e.inspect
          retry
      end
      case train_type.to_i
      when 1
        if !@trains.keys.include?(train)
          @trains[train] = CargoTrain.new(train)
        else
          puts 'Их есть у меня'
        end
      when 2
        if !@trains.keys.include?(train)
          @trains[train] = PassengerTrain.new(train)
        else
          puts 'Их есть у меня'
        end
      else
        puts 'Опять пытаешь обмануть программу?'
      end
    when 2
      puts "Перечень поездов: #{@trains}"
      gets_train
      if @trains.keys.include?(train)
        @trains.delete(train)
      else
        puts 'Таких не держим'
      end
    when 3
      puts "Перечень поездов: #{@trains}"
    when 4
      gets_train
      puts "List of routes: #{@routes}"
      gets_route
      if @trains.keys.include?(train) && @routes.keys.include?(route)
        @trains[train].add_route(@routes[route])
      else
        puts 'Поезд из другой реальности и маршрут никак не разобрать'
      end
    when 5
      begin
        puts "Перечень поездов: #{@trains}"
        gets_train
        gets_carriage
        Carriage.new(carriage)
      rescue => e
        puts e.inspect
        retry
      end
      if @trains[train] && @trains[train].is_a?(PassengerTrain)
        puts 'Введи количество мест вагона'
        seats_count = gets.chomp.to_i
        @carriages[carriage] = PassengerCarriage.new(carriage, seats_count)
        @trains[train].add_carriage(@carriages[carriage])
      elsif @trains[train] && @trains[train].is_a?(CargoTrain)
        puts 'Введи объём вагона'
        carriage_volume = gets.chomp.to_i
        @carriages[carriage] = CargoCarriage.new(carriage, carriage_volume)
        @trains[train].add_carriage(@carriages[carriage])
      else
        puts 'Это не тот поезд'
      end
    when 6
      puts "Перечень поездов: #{@trains}"
      gets_train
      gets_carriage
      if @trains.keys.include?(train) && @trains[train].carriage_include?(@carriages[carriage])
        @trains[train].del_carriage(@carriages[carriage])
      else
        puts 'эбсэнт или поезд или вагон'
      end
    when 7
      gets_train
      gets_station
      if @trains.keys.include?(train) && @stations.keys.include?(station)
        @trains[train].set_current_station(station)
        @stations[station].add_train(@trains[train])
      else
        puts 'Нет такого поезда или станции'
      end
    when 8
      gets_train
      @trains[train].next_station
    when 9
      gets_train
      @trains[train].prev_station
    when 10
      puts "Поезда #{@trains}"
      gets_station
      @trains.select do |key, value|
        puts "#{key} : #{value}" if value.current_station_id == station
      end
    when 11
      gets_train

      @trains[train].each_carriage do |carriage|
        if carriage.is_a?(CargoCarriage)
          puts "Вагон № #{carriage.number}, тип: #{carriage.class}, \
                свободное пространство: #{carriage.free_volume}, \
                занятое пространство: #{carriage.engaged_volume}"
        elsif carriage.is_a?(PassengerCarriage)
          puts "Вагон № #{carriage.number}, тип: #{carriage.class}, \
                свободных мест: #{carriage.seats_free}, \
                занятых мест: #{carriage.seats_engaged}"
        else
          puts 'Нетиповой вагон'
        end
      end
    when 12
      begin
        puts "Перечень поездов: #{@trains}"
        gets_train
        gets_carriage
        Carriage.new(carriage)
      rescue => e
        puts e.inspect
        retry
      end
      puts 'Занимать. Жми 1'
      puts 'Освобождать. Жми 2'
      choice = gets.chomp
      case choice
      when 1
        if @trains[train].is_a?(PassengerTrain)
          @trains[train].carriages[carriage].occupie_seat
        end
        if @trains[train].is_a?(CargoTrain)
          puts 'Введи объем'
          volume = gets.chomp.to_i
          @trains[train].carriages[carriage].occupie_volume(volume)
        end
      when 2
        if @trains[train].is_a?(PassengerTrain)
          @trains[train].carriages[carriage].release_seat
        end
        if @trains[train].is_a?(CargoTrain)
          puts 'Введи объем'
          volume = gets.chomp.to_i
          @trains[train].carriages[carriage].release_volume(volume)
        end
      else
        puts 'неверный выбор'
      end
    else
      puts 'Поезда так не умеют'
    end
  end
end
end

railway = Menu.new

railway.main_menu
