module Validate
  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  protected
  def valid?(item)
    raise "Неверный формат номера #{self}" if item !~ TRAIN_PATTERN && self.class == 'Train'
    raise "Неверный формат номера #{self} по станции и вагону" if item.length < 2
#непонятно, почему при проверке is_a? происходит NameError: uninitialized constant Validate::Train
#можно было бы тогда сделать так:
    #raise "Неверный формат номера #{self}" if item !~ TRAIN_PATTERN && self.is_a?(Train)
    #raise "Неверный формат номера #{self} по станции" if item.length < 1 && self.is_a?(Station)
    #raise "Неверный формат номера #{self} по станции и вагону" if item.length < 1 && self.is_a?(Carriage)
    true
  end
end
