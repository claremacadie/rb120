# classes_objects1.rb

module Walkable
  def walk
    puts "Let's go for a walk!"
  end
end

class Cat
  include Walkable
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def greet
    puts "Hello. My name is #{name}!"
  end

end

kitty = Cat.new("Kitty")
kitty.greet
kitty.walk