class Station
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def add_train(train)
    self.trains << train
  end

  def del_train(train)
    self.train.delete(train)
  end
end