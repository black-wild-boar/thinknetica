require './modules/instance_counter.rb'

class Station
  include InstanceCounter
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

  def self.all
    puts "Все станции: #{@@all_stations} "
  end

end