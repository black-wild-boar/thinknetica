class CargoCarriage < Carriage
  #собственно, методы-геттеры
  attr_reader :full_volume, :engaged_volume

  def initialize(number, full_volume)
    super(number)
    @full_volume = full_volume
  end
  
  def occupie_volume(size)
    if @full_volume > size
      raise "Нельзя занять больше объем, чем есть"
    else
      @engaged_volume = size
    end
  end

  def free_volume?
    @engaged_volume ||= 0
    @full_volume - @engaged_volume 
  end

private
  attr_writer :full_volume, :engaged_volume
end