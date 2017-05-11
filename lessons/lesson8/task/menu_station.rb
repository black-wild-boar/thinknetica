class MenuStation

  attr_accessor :station

  def initialize
    @stations  = {}
  end

  def add
    begin
      p 'Enter station name'
      name = gets.chomp
      @station = Station.new(name)
    rescue => e
      puts e.inspect
      retry
    end
    @station.add(self)
    #@stations[@station.name] = @station
  end

  def del#m_remove_station
    p 'Enter station name'
    station = gets.chomp
    # if @stations.key?(station)
    #   @stations.delete(station)
    if Station.exits?(station)
      Station.del(station)
    else
      p 'No station'
    end
  end
#use real class
  def list#m_staions_list
    #p @stations
    @station.list
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
end
