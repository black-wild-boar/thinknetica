
class MenuStation
  attr_accessor :station

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

  def del
    p 'Enter station name'
    station = gets.chomp
    @station.del(station)
  end

  def list
    @station.list unless @station.nil?
  end

  def trains_on_station
    p 'Enter station name'
    station = gets.chomp
    Station.find(station).trains_on_station
  end
end
