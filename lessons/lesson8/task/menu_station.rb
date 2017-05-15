
class MenuStation

  attr_accessor :station
#+
  def add
    begin
      p 'Enter station name'
      name = gets.chomp
      @station = Station.new(name)
    rescue => e
      puts e.inspect
      retry
    end
    @station.add(@station)
  end
#+
  def del#m_remove_station
    p 'Enter station name'
    name = gets.chomp
    @station.del(name)
  end
#+
  def list#m_staions_list
    @station.list
  end

  def train_on_station
    p 'Enter train name'
    train = gets.chomp
    Station.train_on_station(train)
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
