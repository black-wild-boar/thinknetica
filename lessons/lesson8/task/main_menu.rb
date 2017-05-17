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

class MainMenu
  def initialize
    @m_station = MenuStation.new
    @m_route   = MenuRoute.new
    @m_train   = MenuTrain.new
  end

  def menu_text
    puts "\nWelcome to railway station system! (choose menu number)"
    puts "1. Stations\n2. Routes\n3. Trains\nEnter exit to escape"
  end

  def menu
    loop do
      menu_text
      choice =
        { '1' => -> { stations }, '2' => -> { routes }, '3' => -> { trains } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def station_text
    puts "\nStations (choose menu number)"
    puts "1. Add\n2. Remove\n3. Show all"
    puts "4. Show all trains on station\nEnter exit to escape"
  end

  def stations
    loop do
      station_text
      choice =
        { '1' => -> { @m_station.add }, '2' => -> { @m_station.del },
          '3' => -> { @m_station.list },
          '4' => -> { @m_station.trains_on_station } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def route_text
    puts "\nRoutes (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add station\n5. Remove station\nEnter exit to escape"
  end

  def routes
    loop do
      route_text
      choice =
        { '1' => -> { @m_route.add }, '2' => -> { @m_route.del },
          '3' => -> { @m_route.list }, '4' => -> { @m_route.add_station },
          '5' => -> { @m_route.del_station } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def train_text
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show all carriage\n11. Employ/release carriage space"
    puts 'Enter exit to escape'
  end

  def trains
    loop do
      train_text
      choice =
        { '1' => -> { @m_train.add }, '2' => -> { @m_train.del },
          '3' => -> { @m_train.list }, '4' => -> { @m_train.add_route },
          '5' => -> { @m_train.add_wagon }, '6' => -> { @m_train.del_wagon },
          '7' => -> { @m_train.current_station },
          '8' => -> { @m_train.next_station },
          '9' => -> { @m_train.prev_station },
          '10' => -> { @m_train.wagons_list },
          '11' => -> { @m_train.wagon_space } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end
end

m_main = MainMenu.new
m_main.menu
