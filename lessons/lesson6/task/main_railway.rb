require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require './modules/validate.rb'

class Menu

attr_accessor :all_stations, :all_routes, :all_trains, :all_carriages
  include Validate
  
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
      puts "Рады приветствовать Вас этим дивным временем суток на нашей трешовой станции!"
      puts "\n"
      puts "Управление станциями. Жми 1"
      puts "Управление маршрутами. Жми 2"
      puts "Управление поездами. Жми 3"
      puts "Для выхода введи exit"
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
        puts "Кто здесь?"  
      end
    end
  end

  def stations_menu

    key = ''
    while key != 'exit' do
      puts "\n"

      puts "Первый круг ада. Станции."
      puts "Добавить. Жми 1"
      puts "Удалить. Жми 2"
      puts "Покажи мне их. Жми 3"
      puts "Для выхода введи exit"
      key = gets.chomp

      case key.to_i 
      when 1
        begin
          puts "Введи имя этой прекрасной станции"
          station_name = gets.chomp
          station = Station.new(station_name)
          valid?(station_name)
          rescue
          puts "Неправильное имя станции"
          retry
        end
        @all_stations[station.name] = station
      when 2
        puts "Введи имя этой прекрасной станции"
        station_name = gets.chomp
        if @all_stations.keys.include?(station_name)
          @all_stations.delete(station_name)
        else
          puts "Нет такой станции. Вообще нет)"
        end
      when 3
        puts "Узри же, смертный, ярость станций"
        puts @all_stations
      else 
        puts "Станции такого не умеют"  
      end
    end
  end

  def routes_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Второй круг ада. Маршруты."
      puts "Добавить. Жми 1"
      puts "Удалить. Жми 2"
      puts "Покажи мне их все. Жми 3"
      puts "Добавить станцию радости. Жми 4"
      puts "Уничтожить станцию ужаса. Жми 5"

      puts "Для выхода введи exit"
      key = gets.chomp

      case key.to_i 
      when 1
        puts "Как назвать хочешь ты его?"
        route_name = gets.chomp
        puts "Станций перечень #{@all_stations}"
        puts "Введи имя начала"
        station_first = gets.chomp
        puts "Введи имя конца"
        station_last = gets.chomp

        if @all_stations.keys.include?(station_first) && @all_stations.keys.include?(station_last) && !@all_routes.include?(route_name)
          @all_routes[route_name] = Route.new(station_first,station_last)
        else
          puts "Нет станции такой или маршрут тоже... еcть"
        end        
        
      when 2
        puts "Имя. Введи его имя!"
        route_name = gets.chomp
        if !@all_routes.keys.include?(route_name)
          puts "Ты чего удалять-то пытаешься... нету его и не было никогда"
        else
          puts "Отправляйся в nil, маршрут #{route_name}"
          @all_routes.delete(route_name)
        end
      when 3
        puts "Маршруты-отступники"
        puts @all_routes
      when 4
        puts "Месть павших маршрутов. Добавление станции"
        puts @all_routes
        puts "Назови маршрут"
        route_name = gets.chomp
        puts "Давай сюда имя станции"
        station_name = gets.chomp
        if @all_routes.keys.include?(route_name) && @all_stations.keys.include?(station_name)
          @all_routes[route_name].add_station(station_name)
        else
          puts "Нееееттт!!! Нет маршрута! Или есть уже такая станция"
        end
      when 5
        puts "А какой-такой маршрут для удаления станции"
        route_name = gets.chomp
        puts "Скажи имя грешника"
        station_name = gets.chomp
        if @all_routes.include?(route_name) && @all_routes[route_name].stations.include?(station_name)
          @all_routes[route_name].del_station(station_name)
        else
          puts "Не знаю таких"
        end
      else 
        puts "Станции такого не умеют"  
      end
    end
  end

  def trains_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Третий круг ада. Поезда."
      puts "Добавить. Жми 1"
      puts "Удалить. Жми 2"
      puts "Явитесь, поезда! Жми 3"
      puts "Послать поезд по маршруту. Жми 4"
      puts "Добавить вагон балласта. Жми 5"
      puts "Уничтожить балласта вагон. Жми 6"
      puts "Отправить поезд на станцию в даль. Жми 7"
      puts "Перевести поезд на следующую станцию. Жми 8"
      puts "Перевести поезд на предыдущую станцию. Жми 9"
      puts "Поезда на станции. Жми 10"
      puts "Для выхода введи exit"
      key = gets.chomp

      case key.to_i 
      when 1
        begin
        puts "И как мы назовём этот поезд?"
        train_name = gets.chomp
        puts "Добавим немного красок"
        puts "Грузовой (нажми 1), Пассажирский (нажми 2)"
        train_type = gets.chomp
        
        valid?(train_name)
        #Train.check_valid(train_name)
        rescue
        puts "Неправильный номер поезда"
        retry
        end  
        case train_type.to_i
        when 1
          if !@all_trains.keys.include?(train_name)
            @all_trains[train_name] = CargoTrain.new(train_name)
          else
            puts "Их есть у меня"
          end
        when 2
          if !@all_trains.keys.include?(train_name)
            @all_trains[train_name] = PassengerTrain.new(train_name)
          else
            puts "Их есть у меня"
          end
        else
          puts "Опять пытаешь обмануть программу?"
        end
      when 2
        puts "Поезда все."
        puts @all_trains
        puts "Имя. Введи имя для казни!"
        train_name = gets.chomp
        if @all_trains.keys.include?(train_name)
          @all_trains.delete(train_name)
        else
          puts "Таких не держим"
        end
      when 3
        puts "Поезда. Месть павших"
        puts @all_trains
      when 4
        puts @all_trains
        puts "Выбери поезд"
        train_name  = gets.chomp
        puts @all_routes
        puts "Куда же его послать?"
        route_name  = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_routes.keys.include?(route_name)
          @all_trains[train_name].add_route(@all_routes[route_name])
          puts @all_trains
        else
          puts "Поезд из другой реальности и маршрут никак не разобрать"
        end
      when 5
        begin
        puts @all_trains
        puts "Выбери уже поезд"
        train_name  = gets.chomp
        puts "Ну и вагон назови"
        carriage_name = gets.chomp
        valid?(carriage_name)
        rescue
          puts "Неправильное название вагона"
        retry
        end
#учитываю, что есть общий перечень вагонов
#выражение справа от & выполнится, только если слева != nil 
        if @all_trains[train_name] && @all_trains[train_name].is_a?(PassengerTrain)
          @all_carriages[carriage_name] = PassengerCarriage.new(carriage_name)
          @all_trains[train_name].add_carriage(@all_carriages[carriage_name])
        #elsif @all_trains.keys.include?(train_name) && @all_trains[train_name].is_a?(CargoTrain)
        elsif @all_trains[train_name] && @all_trains[train_name].is_a?(CargoTrain)
          @all_carriages[carriage_name] = CargoCarriage.new(carriage_name)
          @all_trains[train_name].add_carriage(@all_carriages[carriage_name])
        else
          puts "Это не тот поезд"
        end
      when 6
        puts @all_trains
        puts "Выбери уже поезд"
        train_name  = gets.chomp
        puts "Вагон на удаление"
        carriage_name = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_trains[train_name].carriage_include?(@all_carriages[carriage_name])
          @all_trains[train_name].del_carriage(@all_carriages[carriage_name])
        else
          puts "эбсэнт или поезд или вагон"
        end
      when 7
        puts "А пошлю ка я поезд"
        train_name  = gets.chomp
        puts "На станцию"
        station_name  = gets.chomp
        if @all_trains.keys.include?(train_name) && @all_stations.keys.include?(station_name)
          @all_trains[train_name].set_current_station(station_name)
        else
          puts "Нет такого поезда или станции"
        end
      when 8
        puts "Выбери поезд"
        train_name  = gets.chomp
        @all_trains[train_name].next_station
      when 9
        puts "Выбери поезд"
        train_name  = gets.chomp
        @all_trains[train_name].prev_station
      when 10
        puts "Поезда #{@all_trains}"
        puts "Хочу найти поезда на станции"
        station_name = gets.chomp
        @all_trains.select { |key, value| puts "#{key} : #{value}" if value.current_station_id == station_name}
      else 
        puts "Поезда так не умеют" 
      end
    end
  end

end

railway = Menu.new

railway.main_menu
