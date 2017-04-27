class PassengerCarriage < Carriage

  attr_reader :seats_count, :seats_engaged

  def initialize(number, seats_count, seats_engaged = 0)
    super(number)
    @seats_count = seats_count
    @seats_engaged = seats_engaged
  end

  def occupie_seat
    @seats_engaged += 1 if seats_free > 0
  end

  def release_seat
    @seats_engaged -= 1 if @seats_engaged > 0
  end

  def seats_free
    @seats_count - @seats_engaged
  end

  private
  attr_writer :seats_count, :seats_engaged
end