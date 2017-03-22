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
#      - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
#      - Назначать маршрут поезду
#      - Добавлять вагоны к поезду
#      - Отцеплять вагоны от поезда
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

  def self.main_menu
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

  def self.stations_menu

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
        Station.station_add(Station.new(gets.chomp))
      when 2
        puts "Введи имя этой прекрасной станции"
        Station.station_remove(gets.chomp)
      when 3
        puts "Узри же, смертный, ярость станций"
        Station.stations_show_all
      else 
        puts "Станции такого не умеют"  
      end
    end
  end

  def self.routes_menu

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
        puts "Станций перечень"
        Station.stations_show_all
        puts "Введи имя начала"
        station_first = gets.chomp
        puts "Введи имя конца"
        station_last = gets.chomp

        if Station.include_station?(station_first) && Station.include_station?(station_last) && !Route.include_route?(route_name)
          Route.add_to_routes(route_name, Route.new(station_first,station_last))
        else
          puts "Нет станции такой или маршрута тоже... нет"
        end        
        
      when 2
        puts "Имя. Введи его имя!"
        route_name = gets.chomp
        if !Route.include_route?(route_name)
          puts "Ты чего удалять-то пытаешься... нету его и не было никогда"
        else
          puts "Отправляйся в nil, маршрут #{route_name}"
          Route.remove_from_routes(route_name)
        end
      when 3
        
        puts "Маршруты-отступники"
        Route.show_all
      when 4
        puts "Месть павших маршрутов"
        Route.show_all
        puts "Назови маршрут"
        route_name = gets.chomp
        puts "Давай сюда имя станции"
        station_name = gets.chomp
        

        #if Station.include_station?(station_name)
        #  puts "Этого уже и так много"
        #else
        Route.add_station(station_name)
        #end
      when 5
        puts "Скажи имя грешника"
        Route.remove_station(station_name)
      else 
        puts "Станции такого не умеют"  
      end
    end
  end


  def self.trains_menu

    key = ''
    while key != 'exit' do
      puts "\n"
      puts "Третий круг ада. Поезда."
      puts "Добавить. Жми 1"
      puts "Удалить. Жми 2"
      puts "Явитесь, поезда! Жми 3"
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
        puts "Имя. Введи его имя!"
        route_name = gets.chomp
        if !Route.include_route?(route_name)
          puts "Ты чего удалять-то пытаешься... нету его и не было никогда"
        else
          puts "Отправляйся в nil, маршрут #{route_name}"
          Route.remove_from_routes(route_name)
        end
      when 3
        puts "Поезда. Месть павших"
        Train.trains_show_all
      else 
        puts "Станции такого не умеют"  
      end
    end
  end

end

Menu.main_menu

#t1 = Train.new(101)
#p1 = PassengerTrain.new(201)
#p2 = PassengerTrain.new(202)
#c1 = CargoTrain.new(301)

#puts t1
#puts p1
#puts p2
#puts c1

#pc1 = PassengerCarriage.new(1001)
#pc2 = PassengerCarriage.new(1002)
#cc1 = CargoCarriage.new(2001)
#cc2 = CargoCarriage.new(2002)

#p1.carriage_add(pc1)
#p2.carriage_add(cc1)

#p1.carriage_add(pc2)
##p1.carriage_add(131)

#puts "1 #{Carriage.show_carriages}"
#puts t1.inspect
#puts p1.inspect
#puts p2.inspect
#puts c1.inspect


##Train.train_add_to_trains(t1)
##Train.train_add_to_trains(p1)

##puts "2 #{Train.trains_show_all}"
