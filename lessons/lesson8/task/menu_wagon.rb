
class MenuWagon


  # to cut main class by separate train/station/wagon/route classes
  # bug with exit
  def choose_w_type(train, carriage)
    p 'Enter count'
    count = gets.chomp.to_i
    choose_w_type2(train, carriage, count) if @trains[train]
  end

  def choose_w_type2(train, carriage, count)
    wagon_types =
      { 'PassengerTrain' => proc { PassengerCarriage.new(carriage, count) },
        'CargoTrain' => proc { CargoCarriage.new(carriage, count) } }
    @carriages[carriage] = wagon_types[@trains[train].class.to_s].call
    @trains[train].add_carriage(@carriages[carriage])
  end

  def m_add_wagon
    begin
      p 'Enter train name'
      train = gets.chomp
      p 'Enter carriage name'
      carriage = gets.chomp
      Carriage.new(carriage)
    rescue => e
      puts e.inspect
      retry
    end
    choose_w_type(train, carriage)
  end

  def m_check_train_key(train)
    p 'Wrong train!' if @trains.key?(train)
  end

  def m_remove_wagon
    p 'Enter train name'
    train = gets.chomp
    p 'Enter carriage name'
    carriage = gets.chomp
    if @trains.key?(train)
    elsif @trains[train].carriage_include?(@carriages[carriage])
      @trains[train].del_carriage(@carriages[carriage])
    else
      p 'Wrong train or carriage!'
    end
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

#menu_wagon = MenuWagon.new

