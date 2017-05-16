class MenuTrain
  attr_accessor :train

  def train_type(train)
    p '1.Cargo/2.Passenger'
    train_type =
      { '1' => proc { CargoTrain.new(train) },
        '2' => proc { PassengerTrain.new(train) } }
    @train.add(train_type[gets.chomp].call)
  end

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

  def del
    p 'Enter train name'
    train = gets.chomp
    @train.del(train)
  end

  def list
    @train.list
  end

  def add_route
    p 'Enter train'
    train = gets.chomp
    p 'Enter route name'
    route = gets.chomp
    @train.add_route(train, route)
  end

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

  def wagon_type(train, wagon)
    p 'Enter count'
    count = gets.chomp.to_i
    wagon_types =
      { 'PassengerTrain' => proc { PassengerCarriage.new(wagon, count) },
        'CargoTrain' => proc { CargoCarriage.new(wagon, count) } }
    train.add_wagon(wagon_types[train.class.to_s].call)
  end

  def del_wagon
    begin
      p 'Enter train name'
      train = gets.chomp
      p 'Enter wagon name'
      wagon = gets.chomp
      Carriage.new(wagon)
    rescue => e
      puts e.inspect
      retry
    end
    Train.find(train).del_wagon(wagon)
  end

  def current_station
    p 'Enter train name'
    train = gets.chomp
    p 'Enter station name'
    station = gets.chomp
    Train.find(train).current_station(station)
  end

  def next_station
    p 'Enter train name'
    train = gets.chomp
    Train.find(train).next_station
  end

  def prev_station
    p 'Enter train name'
    train = gets.chomp
    Train.find(train).prev_station
  end

  def wagons_list
    p 'Enter train name'
    train = gets.chomp
    Train.find(train).wagons_list
  end

  def wagon_space
    p 'Enter train name'
    train = gets.chomp
    p 'Enter wagon number'
    number = gets.chomp
    wagon_volume(train, number)
  end

  def wagon_volume(train, wagon)
    p '1.Employ/2.Release'
    choose = gets.chomp.to_s
    employ_choice = {
      '1' => proc { wagon_employ(train, wagon) },
      '2' => proc { wagon_release(train, wagon) }
    }
    employ_choice[choose].call
  end

  def wagon_employ(train, wagon)
    p 'Enter volume'
    volume = gets.chomp.to_i
    train_obj = Train.find(train)
    wagon_employ =
      { 'CargoTrain' => proc { train_obj.cargo_wagon_employ(wagon, volume) },
        'PassengerTrain' => proc { train_obj.passenger_wagon_employ(wagon) } }
    wagon_employ[train_obj.class.to_s].call
  end

  def wagon_release(train, wagon)
    p 'Enter volume'
    volume = gets.chomp.to_i
    train_obj = Train.find(train)
    wagon_release =
      { 'CargoTrain' => proc { train_obj.cargo_wagon_release(wagon, volume) },
        'PassengerTrain' => proc { train_obj.passenger_wagon_release(wagon) } }
    wagon_release[train_obj.class.to_s].call
  end

  # def m_cargo_free_engaged(wagon)
  #   p "Carriage N #{wagon.number}, "\
  #     "type: #{wagon.class}, " \
  #     "free space: #{wagon.free_volume}, "\
  #     "engaged volume: #{wagon.engaged_volume}"
  # end

  # def m_passenger_free_engaged(wagon)
  #   p "Carriage N #{wagon.number}, "\
  #     "type: #{wagon.class}, "\
  #     "free seats: #{wagon.seats_free}, "\
  #     "engaged seats: #{wagon.seats_engaged}"
  # end

  def check_carriage_name
    Carriage.new(enter_carriage)
  rescue => e
    puts e.inspect
    retry
  end
end
