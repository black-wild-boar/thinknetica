class MenuStation

  def add
    begin
      p 'Enter station name'
      station = gets.chomp
      station = Station.new(station)
    rescue => e
      puts e.inspect
      retry
    end
    @stations[station.name] = station
  end

  def m_remove_station
    p 'Enter station name'
    station = gets.chomp
    if @stations.key?(station)
      @stations.delete(station)
    else
      p 'No station'
    end
  end

  def m_staions_list
    puts @stations
  end

  def m_add_train_to_station(station)
    p 'Enter station name'
    station = gets.chomp
    @stations[station].each_train do |train|
      puts "Train N #{train.number}, type: #{train.class},'/
      'carriage count: #{train.carriages.length}"
    end
  end

  def m_train_on_station
    if @stations[station].nil? || @stations[station].train.empty?
      p 'No train on station'
    else
      m_add_train_to_station(station)
    end
  end

  def stations_menu
    m_stations
    @choice[gets.chomp].call
  end
end
