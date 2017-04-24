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
  @stations  = {}
  @routes    = {}
  @trains    = {}
  @carriages = {}
end

def main_menu
  key = ''

  while key != 'exit' do
    puts "\n"
    puts 'Рады приветствовать Вас на нашей трешовой станции!'
    puts "\n"
    puts 'Управление станциями. Жми 1'
    puts 'Управление маршрутами. Жми 2'
    puts 'Управление поездами. Жми 3'
    puts 'Для выхода введи exit'
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
      puts 'Кто здесь?'
    end
  end
end

def stations_menu

  key = ''
  while key != 'exit' do
    puts "\n"

    puts 'Первый круг ада. Станции.'
    puts 'Добавить. Жми 1'
    puts 'Удалить. Жми 2'
    puts 'Покажи мне их. Жми 3'
    puts 'Узреть все поезда на станциях. Жми 4'
    puts 'Для выхода введи exit'
    key = gets.chomp

    case key.to_i
    when 1
      begin
        puts 'Введи имя этой прекрасной станции'
        station = gets.chomp
        station = Station.new(station)
      rescue => e
        puts e.inspect
        retry
      end
      @stations[station.name] = station
    when 2
      puts 'Введи имя этой прекрасной станции'
      station = gets.chomp
      if @stations.keys.include?(station)
        @stations.delete(station)
      else
        puts 'Нет такой станции. Вообще нет)'
      end
    when 3
      puts 'Узри же, смертный, ярость станций'
      puts @stations
    when 4
      puts 'Введи название станции'
      station = gets.chomp
      @stations[station].each_train do |train|
        puts "Поезд № #{train.number}, \
        тип: #{train.class}, \
        количество вагонов: #{train.carriages.length}"
      end
    else
      puts 'Станции такого не умеют'
    end
  end
end

def routes_menu

  key = ''
  while key != 'exit' do
    puts "\n"
    puts 'Второй круг ада. Маршруты.'
    puts 'Добавить. Жми 1'
    puts 'Удалить. Жми 2'
    puts 'Покажи мне их все. Жми 3'
    puts 'Добавить станцию радости. Жми 4'
    puts 'Уничтожить станцию ужаса. Жми 5'

    puts 'Для выхода введи exit'
    key = gets.chomp

    case key.to_i
    when 1
      puts 'Как назвать хочешь ты его?'
      route = gets.chomp
      puts "Станций перечень #{@stations}"
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
      puts 'Имя. Введи его имя!'
      route = gets.chomp
      if !@routes.keys.include?(route)
        puts 'Ты чего удалять-то пытаешься... нету его и не было никогда'
      else
        puts "Отправляйся в nil, маршрут #{route}"
        @routes.delete(route)
      end
    when 3
      puts 'Маршруты-отступники'
      puts @routes
    when 4
      puts 'Месть павших маршрутов. Добавление станции'
      puts @routes
      puts 'Назови маршрут'
      route = gets.chomp
      puts 'Давай сюда имя станции'
      station = gets.chomp
      if @routes.keys.include?(route) && @stations.keys.include?(station)
        @routes[route].add_station(station)
      else
        puts 'Нееееттт!!! Нет маршрута! Или есть уже такая станция'
      end
    when 5
      puts 'А какой-такой маршрут для удаления станции'
      route = gets.chomp
      puts 'Скажи имя грешника'
      station = gets.chomp
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
    puts 'Для выхода введи exit'
    key = gets.chomp

    case key.to_i
    when 1
      begin
        puts 'И как мы назовём этот поезд?'
        train = gets.chomp
        puts 'Добавим немного красок'
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
      puts 'Поезда все.'
      puts @trains
      puts 'Имя. Введи имя для казни!'
      train = gets.chomp
      if @trains.keys.include?(train)
        @trains.delete(train)
      else
        puts 'Таких не держим'
      end
    when 3
      puts 'Поезда. Месть павших'
      puts @trains
    when 4
      puts @trains
      puts 'Выбери поезд'
      train = gets.chomp
      puts @routes
      puts 'Куда же его послать?'
      route = gets.chomp
      if @trains.keys.include?(train) && @routes.keys.include?(route)
        @trains[train].add_route(@routes[route])
        puts @trains
      else
        puts 'Поезд из другой реальности и маршрут никак не разобрать'
      end
    when 5
      begin
        puts @trains
        puts 'Выбери уже поезд'
        train = gets.chomp
        puts 'Ну и вагон назови'
        carriage = gets.chomp
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
      puts @trains
      puts 'Выбери уже поезд'
      train = gets.chomp
      puts 'Вагон на удаление'
      carriage = gets.chomp
      if @trains.keys.include?(train) && @trains[train].carriage_include?(@carriages[carriage])
        @trains[train].del_carriage(@carriages[carriage])
      else
        puts 'эбсэнт или поезд или вагон'
      end
    when 7
      puts 'А пошлю ка я поезд'
      train = gets.chomp
      puts 'На станцию'
      station = gets.chomp
      if @trains.keys.include?(train) && @stations.keys.include?(station)
        @trains[train].set_current_station(station)
        @stations[station].add_train(@trains[train])
      else
        puts 'Нет такого поезда или станции'
      end
    when 8
      puts 'Выбери поезд'
      train = gets.chomp
      @trains[train].next_station
    when 9
      puts 'Выбери поезд'
      train = gets.chomp
      @trains[train].prev_station
    when 10
      puts "Поезда #{@trains}"
      puts 'Хочу найти поезда на станции'
      station = gets.chomp
      @trains.select do |key, value|
        puts "#{key} : #{value}" if value.current_station_id == station
      end
    when 11
      puts 'Выбери поезд'
      train = gets.chomp

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
        puts @trains
        puts 'Выбери уже поезд'
        train = gets.chomp
        puts 'Ну и вагон назови'
        carriage = gets.chomp
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
