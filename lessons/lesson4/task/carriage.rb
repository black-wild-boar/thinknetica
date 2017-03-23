class Carriage
  attr_reader :number, :type

  @carriages = {}

  def initialize(number)
    @number = number
    @type = self.class
  end

protected
  attr_writer :number

#должен существовать общий реестр вагонов
  def self.carriage_add(carriage_name)
#    if @carriages.empty?
#      puts "Безжизненная пустыня 2"
#      @carriages[carriage_name.class.name.to_sym] = []
#      @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#    elsif !@carriages.include?(carriage_name.class.name.to_sym) 
#      puts "Такой вангончик-то имеется"
#      @carriages[carriage_name.class.name.to_sym] = []
#      @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#    else
#      puts "Ща добавлю"
#      if !@carriages[carriage_name.class.name.to_sym].include?(carriage_name.number)
#        @carriages[carriage_name.class.name.to_sym] << carriage_name.number
#      else
#        puts "Номер вагона уже есть в перечне"
#      end
#    end
    if @carriages.empty?
      puts "Безжизненная пустыня 2"
      @carriages[carriage_name.type] = []
      @carriages[carriage_name.type] << carriage_name.number
    elsif !@carriages.include?(carriage_name.type)
      puts "Вангончик-то нового типа"
      @carriages[carriage_name.type] = []
      @carriages[carriage_name.type] << carriage_name.number
    else
      puts "Ща добавлю"
      if !@carriages[carriage_name.type].include?(carriage_name.number)
        @carriages[carriage_name.type] << carriage_name.number
      else
        puts "Номер вагона уже есть в перечне"
      end
    end


##    @carriages.store(train_type, carriage_name)
  end

  def self.show_carriages
    @carriages.each_pair { |key, value| puts "Есть вагоны: #{key} #{value}"}
  end
end