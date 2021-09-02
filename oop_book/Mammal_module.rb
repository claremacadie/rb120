# Mammal_module.rb

module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.some_out_of_place_method(num)
    num ** 2
  end
end

doggy = Mammal::Dog.new
doggy.speak("Woof!")

kitty = Mammal::Cat.new
kitty.say_name("Kitty")

value = Mammal.some_out_of_place_method(4)
p value
