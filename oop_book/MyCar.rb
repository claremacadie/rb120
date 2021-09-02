# MyCar.rb

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0
  attr_accessor :color, :model, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    puts "There are #{@@number_of_vehicles} vehicles."
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas."
  end

  def speed_up(num)
    @speed +=num
  end

  def brake(num)
    @speed -+ num
  end

  def shut_car_off
    @speed = 0
  end

  def spray_paint(new_color)
    @color = new_color
  end

  def age
    "This vehicle is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "The car is a #{year}, #{color} #{model}."
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2
end

first_car = MyCar.new(2007, 'blue', 'Golf')
first_truck = MyTruck.new(2011, 'black', 'Ford transit')
puts first_car.age

# first_car.speed_up(200)
# puts first_car.speed
# first_truck.speed_up(50)
# first_truck.shut_car_off
# puts first_truck.speed

# puts Vehicle.ancestors
# puts MyCar.ancestors
# puts MyTruck.ancestors

# p first_truck.can_tow?(1)
# p first_truck.can_tow?(10000)

# MyCar.number_of_vehicles

# first_car.color = 'red'
# puts first_car.color
# first_car.spray_paint('black')
# puts first_car.color
# MyCar.gas_mileage(30, 600)
# puts first_car
