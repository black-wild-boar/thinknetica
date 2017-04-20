class PassengerCarriage < Carriage
  #метод-геттер
  attr_reader :seats_count, :seats_engaged

  def initialize(number, seats_count, seats_engaged=0)
    super(number)
    @seats_count = seats_count
    @seats_engaged = 0
  end

  def occupie_seat
    if (@seats_count - @seats_engaged) > 0
      @seats_engaged += 1
    else
      raise "Все места заняты"
    end
  end

  def release_seat
    if (@seats_engaged - 1) >= 0
      @seats_engaged -= 1
    else
      raise "Все места свободны"
    end
  end

  def seats_free?
    @seats_engaged ||= 0
    @seats_count - @seats_engaged
  end

  private
  attr_writer :seats_count, :seats_engaged
end