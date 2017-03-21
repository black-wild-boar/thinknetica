require_relative 'car'
require_relative 'truck'
require_relative 'sportcar'
require_relative 'driver'
require_relative 'x'

truck = Truck.new
truck.start_engine
puts "Truck RPM: #{truck.current_rpm}"

car = Car.new
car.start_engine
puts "Car RPM: #{car.current_rpm}"

sportcar = SportCar.new
sportcar.start_engine
puts "SportCar RPM: #{sportcar.current_rpm}"

x = X.new
driver = Driver.new
driver.drive(x)
#=> Hi