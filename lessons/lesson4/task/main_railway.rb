# Задание:

#+ Разбить программу на отдельные классы (каждый класс в отдельном файле)
# Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя
# для классов, который будет содержать общие методы и свойства Определить,
# какие методы могут быть помещены в private/protected и вынести их в такую
# секцию. В комментарии к методу обосновать, почему он был вынесен в
# private/protected 
#+Вагоны теперь делятся на грузовые и пассажирские
#+ (отдельные классы). К пассажирскому поезду можно прицепить только
#+ пассажирские, к грузовому - грузовые.  При добавлении вагона к поезду,
#+ объект вагона должен передаваться как аругмент метода и сохраняться во
#+ внутреннем массиве поезда, в отличие от предыдущего задания, где мы считали
#+ только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно
#+ удалить.

# Добавить текстовый интерфейс:

# Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
#+      - Создавать станции
#+      - Создавать поезда
#+      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#+      - Назначать маршрут поезду
#+      - Добавлять вагоны к поезду
#+      - Отцеплять вагоны от поезда
#      - Перемещать поезд по маршруту вперед и назад
#      - +Просматривать список станций и -список поездов на станции

# В качестве ответа приложить ссылку на репозиторий с решением

#l4-1
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'

class Menu

@@all_stations = {}
@@all_routes = {}
@@all_trains = {}

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
        puts "Введи имя этой прекрасной станции"
        station_name = gets.chomp
        @@all_stations[station_name] = Station.new(station_name)
      when 2
        puts "Введи имя этой прекрасной станции"
        station_name = gets.chomp
        if @@all_stations.keys.include?(station_name)
          puts "daaaa"
          puts @@all_stations[station_name]
          @@all_stations.delete(station_name)
        else
          puts "neeet"
        end
      when 3
        puts "Узри же, смертный, ярость станций"
        puts @@all_stations
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
        puts "Станций перечень #{@@all_stations}"
        puts "Введи имя начала"
        station_first = gets.chomp
        puts "Введи имя конца"
        station_last = gets.chomp

        if @@all_stations.keys.include?(station_first) && @@all_stations.keys.include?(station_last) && !@@all_routes.include?(route_name)
          puts "123"
          puts @@all_stations.keys.include?(station_first)
          puts "321"
          puts @@all_stations.keys.include?(station_last)

          @@all_routes[route_name] = Route.new(station_first,station_last)
        else
          puts "Нет станции такой или маршрут тоже... еcть"
        end        
        
      when 2
        puts "Имя. Введи его имя!"
        route_name = gets.chomp
        if !@@all_routes.keys.include?(route_name)
          puts "Ты чего удалять-то пытаешься... нету его и не было никогда"
        else
          puts "Отправляйся в nil, маршрут #{route_name}"
          route_name.remove_from_routes
        end
      when 3
        puts "Маршруты-отступники"
        puts @@all_routes
      when 4
        puts "Месть павших маршрутов"
        @@all_routes
        puts "Назови маршрут"
        route_name = gets.chomp
        puts "Давай сюда имя станции"
        station_name = gets.chomp
        #if @@all_routes.include?(route_name)
          route_name.add_station(station_name)
        #else
        #  puts "Нееееттт!!! Нет его!"
        #end
      when 5
        puts "А какой-такой маршрут"
        route_name = gets.chomp
        puts "Скажи имя грешника"
        station_name = gets.chomp
        if Route.route_include?(route_name)
          Route.remove_station(route_name, station_name)
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
      puts "Для выхода введи exit"
      key = gets.chomp

      case key.to_i 
      when 1
        puts "И как мы назовём этот поезд?"
        train_name = gets.chomp
        puts "Добавим немного красок"
        puts "Грузовой (нажми 1), Пассажирский (нажми 2)"
        train_type = gets.chomp
        
        case train_type.to_i
        when 1
          if !Train.train_include?(train_name) #|| (Train.train_include?(train_name) && ("CargoTrain" != Train.get_type(train_name).to_s))
            Train.add_to_trains(train_name, CargoTrain.new(train_name))
          else
            puts "Их есть у меня"
          end
        when 2
          if !Train.train_include?(train_name)
            Train.add_to_trains(train_name, PassengerTrain.new(train_name))
          else
            puts "Их есть у меня"
          end
        else
          puts "Опять пытаешь обмануть программу?"
        end
      when 2
        puts "Поезда все."
        Train.trains_show_all
        puts "Имя. Введи имя для казни!"
        train_name = gets.chomp
        if Train.train_include?(train_name) #|| (Train.train_include?(train_name) && ("CargoTrain" != Train.get_type(train_name).to_s))
          Train.remove_from_trains(train_name)
        else
          puts "Таких не держим"
        end
      when 3
        puts "Поезда. Месть павших"
        Train.trains_show_all
      when 4
        Train.trains_show_all
        puts "Выбери поезд"
        train_name  = gets.chomp
        Route.show_all
        puts "Куда же его послать?"
        route_name  = gets.chomp
        if Train.train_include?(train_name) && Route.route_include?(route_name)
          Train.add_route(train_name, route_name)
        else
          puts "Поезд из другой реальности и маршрут никак не разобрать"
        end
      when 5
        Train.trains_show_all
        puts "Выбери уже поезд"
        train_name  = gets.chomp
        puts "Ну и вагон назови"
        carriage_name = gets.chomp
        Train.carriage_add(train_name, carriage_name)
        puts Carriage.show_carriages.inspect
      when 6
        Train.trains_show_all
        puts "Выбери уже поезд"
        train_name  = gets.chomp
        puts "Вагон на удаление"
        carriage_name = gets.chomp
        Train.carriage_remove(train_name, carriage_name)
      when 7
        puts "А пошлю ка я поезд"
        train_name  = gets.chomp
        puts "На станцию"
        station_name  = gets.chomp

        Train.set_current_station(train_name, station_name)
      when 8
        puts "Выбери поезд"
        train_name  = gets.chomp
        puts "Имя станции"
        station_name  = gets.chomp

        Train.prev_station(train_name, station_name)
      when 9
        puts "Выбери поезд"
        train_name  = gets.chomp
        puts "Имя станции"
        station_name  = gets.chomp

        Train.next_station(train_name, station_name)
      else 
        puts "Поезда так не умеют" 
      end
    end
  end

end

railway = Menu.new

railway.main_menu
