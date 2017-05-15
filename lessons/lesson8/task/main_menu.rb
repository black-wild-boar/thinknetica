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
        { '1' => proc { stations }, '2' => proc { routes },
          '3' => proc { trains } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def station_text
    puts "\nStations (choose menu number)"
    puts "1. Add\n2. Remove\n3. Show all"
    puts "4. Show all train on station\nEnter exit to escape"
  end

  def stations
    loop do
      station_text
      choice =
        { '1' => proc { @m_station.add }, '2' => proc { @m_station.del },
          '3' => proc { @m_station.list },
          '4' => proc { @m_station.train_on_station } }
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
        { '1' => proc { @m_route.add }, '2' => proc { @m_route.del },
          '3' => proc { @m_route.list },
          '4' => proc { @m_route.add_station },
          '5' => proc { @m_route.del_station } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def train_text
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show trains on station\n11. Show all carriage"
    puts "12. Employ/release carriage space\nEnter exit to escape"
  end

  def trains
    loop do
      train_text
      choice =
        { '1' => proc { @m_train.add }, '2' => proc { @m_train.del },
          '3' => proc { @m_train.list }, '4' => proc { @m_train.add_route },
          '5' => proc { @m_train.add_wagon },
          '6' => proc { @m_train.del_wagon },
          '7' => proc { @m_train.set_station },
          '8' => proc { @m_train.next_station },
          '9' => proc { @m_train.prev_station },
          '10' => proc { @m_train.trains_on_station },
          '11' => proc { m_carriages_list },
          '12' => proc { m_wagon_space } }
      key = gets.chomp
      break if key == 'exit'
      choice[key].call if choice.key?(key)
    end
  end

  def wagon_text
  end

  def wagons
  end
end

m_main = MainMenu.new
m_main.menu
