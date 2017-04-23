module Validate
  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  protected

  def valid?(item)
    if item !~ TRAIN_PATTERN && self.class == 'Train'
      raise "Неверный формат номера #{self}"
    end
    if item.length < 2 && self.class == 'Carriage'
      raise "Неверный формат номера #{self} по станции и вагону"
    end
    true
  end
end
