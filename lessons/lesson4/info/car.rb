class Car
  attr_reader :current_rpm

  def initialize
    @current_rpm = 0
  end

  def start_engine
    start_engine! if engine_stopped?
  end

  protected

  attr_writer :current_rpm

  #INITIAL_RPM = 500
  def initial_rpm
    700
  end

  def engine_stopped?
    current_rpm.zero?
  end

  def start_engine!
    self.current_rpm = initial_rpm
  end

  def stop
  end
end