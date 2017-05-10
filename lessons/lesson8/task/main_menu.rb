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
    @@stations  = {}
    @@routes    = {}
    @@carriages = {}
    @@trains    = {}
    menu
  end

  def exit_menu
    puts "Bye!"
  end

  def menu
    loop do
      puts "\nWelcome to railway station system! (choose menu number)"
      puts "1. Stations\n2. Routes\n3. Trains\nEnter exit to escape"
      choice =
        { '1' => proc { stations }, '2' => proc { routes },
          '3' => proc { trains }, 'exit' => proc { exit_menu } }
        choice[gets.chomp].call
        break if choice['exit']
    end
  end

  def stations
    
    puts "\nStations (choose menu number)"
    puts "1. Add\n2. Remove\n3. Show all"
    puts "4. Show all train on station\nEnter exit to escape"
    choice =
      { '1' => proc { MenuStation.new.add }, '2' => proc { m_remove_station },
        '3' => proc { m_staions_list }, '4' => proc { m_train_on_station },
        'exit' => proc { menu } }
    choice[gets.chomp].call
  end

  def routes
    puts "\nRoutes (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add station\n5. Remove station\nEnter exit to escape"
    choice =
      { '1' => proc { m_add_route }, '2' => proc { m_remove_route },
        '3' => proc { m_routes_list }, '4' => proc { m_route_add_station },
        '5' => proc { m_route_remove_station }, 'exit' => proc { menu } }
    choice[gets.chomp].call
  end

  def menu_trains
    puts "\nTrains (choose menu number)\n1. Add\n2. Remove\n3. Show all"
    puts "4. Add route\n5. Add carriage\n6. Remove carriage"
    puts "7. Set current station\n8. Next station\n9. Prev station"
    puts "10. Show trains on station\n11. Show all carriage"
    puts "12. Employ/release carriage space\nEnter exit to escape"
  end

  def trains
    menu_trains
    choice =
      { '1' => proc { m_add_train }, '2' => proc { m_remove_train },
        '3' => proc { m_trains_list }, '4' => proc { m_train_add_route },
        '5' => proc { m_add_wagon }, '6' => proc { m_remove_wagon },
        '7' => proc { m_current_station }, '8' => proc { m_next_station },
        '9' => proc { m_prev_station }, '10' => proc { m_trains_on_station },
        '11' => proc { m_carriages_list }, '12' => proc { m_wagon_space },
        'exit' => proc { menu } }
      choice[gets.chomp].call
  end
end

main_menu = MainMenu.new
