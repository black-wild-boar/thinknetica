class CargoTrain < Train

  def add_carriage(carriage)
    if self.speed == 0 && self.is_a?(CargoTrain) && carriage.is_a?(CargoCarriage) && !carriage_include?(carriage)
      #self.carriages << carriage
      self.carriages[carriage.number] = carriage
    else
      puts "Бегущий поезд лани подобен или тип несовместим или есть уже такой" 
    end
  end
end