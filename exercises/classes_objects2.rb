# classes_objects2.rb

# class Cat
#   @@number_of_cats = 0
#   attr_accessor :name
#   COLOR = 'black'

#   def initialize(name)
#     @name = name
#     @@number_of_cats += 1
#   end

#   def to_s
#     "I'm #{name}!"
#   end

#   def self.total
#     puts "There are #{@@number_of_cats} cats."
#   end

#   def rename(new_name)
#     self.name = new_name
#   end

#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end

#   def personal_greeting
#     puts "Hello! My name is #{name}!"
#   end

#   def greet
#     puts "Hello! My name is #{name} and I'm a #{COLOR} cat!"
#   end

#   def identify
#     self
#   end

# end

# kitty = Cat.new('Sophie')
# puts kitty


# kitty = Cat.new('Benji')
# Cat.total

# Cat.generic_greeting
# kitty.personal_greeting

# p kitty.identify
# p kitty.name
# kitty.rename('Chloe')
# p kitty.name

# kitty.class.generic_greeting

class Person
  attr_writer :secret

  def compare_secret(person)
    self.secret == person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)

