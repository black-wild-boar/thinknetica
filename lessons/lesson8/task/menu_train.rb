class MenuTrain
  
  attr_accessor :train  

  def train_type(train)
      p '1.Cargo/2.Passenger'
      train_type =
        { '1' => proc { CargoTrain.new(train) },
          '2' => proc { PassengerTrain.new(train) } }
      @train.add(train_type[gets.chomp].call)
  end
#+
  def add
    begin
      p 'Enter train name'
      train = gets.chomp
      @train = Train.new(train)
    rescue => e
      puts e.inspect
      retry
    end
    train_type(train)
  end
#+
  def del
    p 'Enter train name'
    train = gets.chomp
    @train.del(train)
  end
#+
  def list
    @train.list
  end
#+
  def add_route
    p 'Enter train'
    train = gets.chomp
    p 'Enter route name'
    route = gets.chomp
    @train.add_route(train, route)
  end
#+
  def add_wagon
    begin
      p 'Enter train name'
      train = gets.chomp
      p 'Enter carriage name'
      wagon = gets.chomp
      Carriage.new(wagon)
    rescue => e
      puts e.inspect
      retry
    end
    wagon_type(Train.find(train), wagon)
  end
#+
  def wagon_type(train, wagon)
    p 'Enter count'
    count = gets.chomp.to_i
    wagon_types =
     { 'PassengerTrain' => proc { PassengerCarriage.new(wagon, count) },
       'CargoTrain' => proc { CargoCarriage.new(wagon, count) } }
    train.add_wagon(wagon_types[train.class.to_s].call)
  end
#+
  def del_wagon
    begin
      p 'Enter train name'
      train = gets.chomp
      p 'Enter carriage name'
      wagon = gets.chomp
      Carriage.new(wagon)
    rescue => e
      puts e.inspect
      retry
    end
    Train.find(train).del_wagon(wagon)
  end
#+
  def set_station
    p 'Enter train name'
    train = gets.chomp
    p 'Enter station name'
    station = gets.chomp
    Train.find(train).set_station(station)

  end
#+
  def next_station
    p 'Enter train name'
    train = gets.chomp
    Train.find(train).next_station
  end
#+
  def prev_station
    p 'Enter train name'
    train = gets.chomp
    Train.find(train).prev_station
  end
#+
  def trains_on_station
    p 'Enter station name'
    station = gets.chomp
    Station.find(station).trains_on_station
    #Train.trains_on_station(station)
  end
#+
  def wagons_list
    p 'Enter train name'
    train = gets.chomp

  end

  def m_cargo_free_engaged(wagon)
    p "Carriage N #{wagon.number}, "\
      "type: #{wagon.class}, " \
      "free space: #{wagon.free_volume}, "\
      "engaged volume: #{wagon.engaged_volume}"
  end

  def m_passenger_free_engaged(wagon)
    p "Carriage N #{wagon.number}, "\
      "type: #{wagon.class}, "\
      "free seats: #{wagon.seats_free}, "\
      "engaged seats: #{wagon.seats_engaged}"
  end

  def m_carriages_list
    p 'Enter train name'
    train = gets.chomp
    @trains[train].each_carriage do |wagon|
      case wagon.class.to_s
      when 'PassengerCarriage' then m_passenger_free_engaged(wagon)
      when 'CargoCarriage' then m_cargo_free_engaged(wagon)
      else
        puts 'Untyped carriage'
      end
    end
  end

  def m_wagon_volume(train, carriage)
    # def m_wagon_volume(enter_train, check_carriage_name)
    p '1.Employ/2.Release'
    choose = gets.chomp.to_s
    p 'Enter count'
    volume = gets.chomp.to_i
    employ_choice = {
      '1' => proc { wagon_employ(train, carriage, volume) },
      '2' => proc { wagon_release(train, carriage, volume) }
    }
    employ_choice[choose].call
  end

  def local_occupie_volume; end

  # or cut with methods
  def wagon_employ(train, carriage, volume)
    # @trains[train].carriages[carriage].
    wagon_employ =
#      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].occupie_seat },
#        'CargoTrain' => proc { @trains[train].carriages[carriage].occupie_volume(volume) } }
      { 'PassengerTrain' => cargo_wagon_employ(train, carriage, volume),
        'CargoTrain' => passenger_wagon_employ(train, carriage, volume) }
    wagon_employ[@trains[enter_train].class.to_s].call
  end
# not working
  def cargo_wagon_employ(train, carriage, volume)
    @trains[train].carriages[carriage].occupie_seat
  end

  def passenger_wagon_employ(train, carriage, volume)
    @trains[train].carriages[carriage].occupie_volume(volume)
  end

  def wagon_release(train, carriage, volume)
    wagon_release =
      { 'PassengerTrain' => proc { @trains[train].carriages[carriage].release_seat },
        'CargoTrain' => proc { @trains[train].carriages[carriage].release_volume(volume) } }
    wagon_release[@trains[train].class.to_s].call
  end

  def enter_train
    p 'Enter train name'
    gets.chomp
  end

  def enter_carriage
    p 'Enter carriage name'
    gets.chomp
  end

  def check_carriage_name
    Carriage.new(enter_carriage)
  rescue => e
    puts e.inspect
    retry
  end

  def m_wagon_space
    # puts enter_train
    # puts enter_carriage
    # begin
    #   Carriage.new(carriage)
    # rescue => e
    #   puts e.inspect
    #   retry
    # end
    # check_carriage_name
    train = enter_train
    carriage = check_carriage_name
    puts train
    puts carriage
    m_wagon_volume(train, carriage)
  end

end
