module Validate
  TRAIN_PATTERN = /^(\w{3}|[a-z]{3})+(-?)+(\d{2}|[a-z]{2})$/

  protected

  def valid?(item)
    if (item !~ TRAIN_PATTERN) && (self.class == 'Train')
      raise 'Wrong train name format'
    end
    raise 'Wrong station/carriage name format' if item.length < 2
    true
  end
end
