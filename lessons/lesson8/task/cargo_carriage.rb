class CargoCarriage < Carriage
  attr_reader :full_volume, :engaged_volume

  def initialize(number, full_volume, engaged_volume = 0)
    super(number)
    @full_volume = full_volume
    @engaged_volume = engaged_volume
  end

  def occupie_volume(size)
    @engaged_volume += size if free_volume >= size
  end

  def release_volume(size)
    @engaged_volume -= size if @engaged_volume >= size
  end

  def free_volume
    @full_volume - @engaged_volume
  end

  private

  attr_writer :full_volume, :engaged_volume
end
