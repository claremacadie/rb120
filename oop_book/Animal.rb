# Animal.rb

module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "Hello!"
  end

  def a_public_method
    "Will this work? " + self.a_protected_method
  end

  protected

  def a_protected_method
    "Yes, I'm protected!"
  end
end

class GoodDog < Animal
  include Swimmable

  def initialize(name, color)
    super(name)
    @color = color
  end


  def speak
    super + " from #{self.name}"
  end
end

class Cat < Animal
end

# sparky = GoodDog.new("Sparky", "brown")
# paws = Cat.new("paws")
# puts sparky.name
# puts sparky.speak
# puts paws.speak
# puts sparky.swim

rolf = Animal.new("Rolf")
p rolf.a_public_method
p rolf.a_protected_method
