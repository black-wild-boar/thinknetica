require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'menu_route'
require_relative 'menu_station'
require_relative 'menu_train'
require_relative 'menu_wagon'

class MainMenu

  def initialize
    #@@stations  = {}
    @@routes    = {}
    @@carriages = {}
    @@trains    = {}
    @@m_station = MenuStation.new
    @@m_route = MenuRoute.new
    @@m_train = MenuTrain.new
  end

  def exit_menu(choice)
      key = gets.chomp
      choice[key].call
  end

  def menu
    loop do
      puts "\nWelcome to railway station system! (choose menu number)"
      puts "1. Stations\n2. Routes\n3. Trains\nEnter exit to escape"
      choice =
        { '1' => proc { stations }, '2' => proc { routes },
          '3' => proc { trains }}#, 'exit' => proc { puts 'Bye!' } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call
    end
  end

  def stations
    #@m_station = MenuStation.new
    loop do
      puts "\nStations (choose menu number)"
      puts "1. Add\n2. Remove\n3. Show all"
      puts "4. Show all train on station\nEnter exit to escape"
      choice =
        { '1' => proc { @@m_station.add }, '2' => proc { @@m_station.del },
          '3' => proc { @@m_station.list }, '4' => proc { m_train_on_station }}#,
          #'exit' => proc { menu } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call
    end
  end

  def routes
    #@m_route = MenuRoute.new
    loop do
      puts "\nRoutes (choose menu number)\n1. Add\n2. Remove\n3. Show all"
      puts "4. Add station\n5. Remove station\nEnter exit to escape"
      choice =
        { '1' => proc { @@m_route.add }, '2' => proc { @@m_route.del },
          '3' => proc { @@m_route.list },
          '4' => proc { @@m_route.add_station },
          '5' => proc { @@m_route.del_station }}#, 'exit' => proc { menu } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call
    end
  end

  def menu_trains
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show trains on station\n11. Show all carriage"
    puts "12. Employ/release carriage space\nEnter exit to escape"
  end

  def trains
    #@m_train = MenuTrain.new
    loop do
      menu_trains
      choice =
        { '1' => proc { @@m_train.add }, '2' => proc { @@m_train.del },
          '3' => proc { @@m_train.list }, '4' => proc { @@m_train.add_route },
          '5' => proc { @@m_train.add_wagon },
          '6' => proc { @@m_train.del_wagon }, 
          '7' => proc { @@m_train.set_station },
          '8' => proc { @@m_train.next_station },
          '9' => proc { @@m_train.prev_station },
          '10' => proc { m_trains_on_station },
          '11' => proc { m_carriages_list }, '12' => proc { m_wagon_space }}#,
          #'exit' => proc { menu } }
#      choice[gets.chomp].call
      key = gets.chomp
      break if key == 'exit'
      choice[key].call
    end
  end
end

m_main = MainMenu.new
m_main.menu
