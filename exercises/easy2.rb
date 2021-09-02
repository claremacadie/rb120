# easy2.rb

# mailable.rb

# module Mailable
#   def print_address
#     puts "#{name}"
#     puts "#{address}"
#     puts "#{city}, #{state} #{zipcode}"
#   end
# end

# class Customer
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# class Employee
#   include Mailable
#   attr_reader :name, :address, :city, :state, :zipcode
# end

# betty = Customer.new
# bob = Employee.new
# betty.print_address
# bob.print_address


#################################
# drivable.rb

# module Drivable
#   def drive
#   end
# end

# class Car
#   include Drivable
# end

# bobs_car = Car.new
# bobs_car.drive


###############################
# house.rb

# class House
#   attr_reader :price
#   include Comparable

#   def initialize(price)
#     @price = price
#   end

#   def <=>(other)
#     price <=> other.price
#   end

# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1


######################
# transform.rb

# class Transform
#   def initialize(str)
#     @str = str
#   end

#   def uppercase
#     @str.upcase
#   end

#   def self.lowercase(str)
#     str.downcase
#   end
# end

# my_data = Transform.new('abc')
# puts my_data.uppercase
# puts Transform.lowercase('XYZ')


########################
# wallet.rb

# class Wallet
#   include Comparable

#   def initialize(amount)
#     @amount = amount
#   end

#   def <=>(other_wallet)
#     amount <=> other_wallet.amount
#   end

#   protected

#   attr_reader :amount
# end

# bills_wallet = Wallet.new(500)
# pennys_wallet = Wallet.new(465)
# if bills_wallet > pennys_wallet
#   puts 'Bill has more money than Penny'
# elsif bills_wallet < pennys_wallet
#   puts 'Penny has more money than Bill'
# else
#   puts 'Bill and Penny have the same amount of money.'
# end


#################################
# pet.rb

# class Pet
#   attr_reader :type, :name
#   def initialize(type, name, shelter)
#     @type = type
#     @name = name
#     shelter.unadopted << self
#   end
# end

# class Owner
#   attr_reader :name
#   attr_accessor :number_of_pets
#   def initialize(name)
#     @name = name
#     @number_of_pets = 0
#   end
# end

# class Shelter
#   attr_accessor :adoptions, :animals, :unadopted
#   def initialize
#     @adoptions = {}
#     @animals = []
#     @unadopted = []
#   end

#   def adopt(owner, pet)
#     total_pets = owner.number_of_pets + 1
#     owner.number_of_pets = total_pets
#     if @adoptions[owner]
#       @adoptions[owner] << pet
#     else
#       @adoptions[owner] = [pet]
#     end
#     @unadopted.delete(pet)
#   end

#   def print_adoptions
#     self.adoptions.each do |owner, pets_array|
#       puts "#{owner.name} has adopted the following pets:"
#       pets_array.each do |pet|
#         puts "a #{pet.type} named #{pet.name}"
#       end
#       puts
#     end
#   end

#   def print_unadoptions
#     puts "The Animal Shelter has the folowing unadopted pets:"
#     @unadopted.each do |pet|
#       puts "a #{pet.type} named #{pet.name}"
#     end
#   end
# end

# shelter = Shelter.new

# daisy        = Pet.new('cat', 'Daisy', shelter)
# hugo         = Pet.new('cat', 'Hugo', shelter)
# butterscotch = Pet.new('cat', 'Butterscotch', shelter)
# pudding      = Pet.new('cat', 'Pudding', shelter)
# darwin       = Pet.new('bearded dragon', 'Darwin', shelter)
# kennedy      = Pet.new('dog', 'Kennedy', shelter)
# sweetie      = Pet.new('parakeet', 'Sweetie Pie', shelter)
# molly        = Pet.new('dog', 'Molly', shelter)
# chester      = Pet.new('fish', 'Chester', shelter)
# asta         = Pet.new('dog', 'Asta', shelter)
# fluffy       = Pet.new('cat', 'Fluffy', shelter)

# phanson  = Owner.new('P Hanson')
# bholmes  = Owner.new('B Holmes')
# cmacadie = Owner.new('C MacAdie')

# shelter.adopt(phanson, butterscotch)
# shelter.adopt(phanson, pudding)
# shelter.adopt(phanson, darwin)
# shelter.adopt(bholmes, kennedy)
# shelter.adopt(bholmes, sweetie)
# shelter.adopt(bholmes, molly)
# shelter.adopt(bholmes, chester)
# shelter.adopt(cmacadie, daisy)
# shelter.adopt(cmacadie, hugo)

# shelter.print_adoptions
# shelter.print_unadoptions
# puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# puts "The Animal shelter has #{shelter.unadopted.size} unadopted pets."


##################################
# expander.rb

# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

# expander = Expander.new('xyz')
# puts expander


#############################
# moving.rb

# module Walkable
#   def walk
#     puts "#{name} #{gait} forward"
#   end
# end

# class Person
#   attr_reader :name
#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   private

#   def gait
#     "strolls"
#   end
# end

# class Cat
#   attr_reader :name
#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   private

#   def gait
#     "saunters"
#   end
# end

# class Cheetah
#   attr_reader :name
#   include Walkable

#   def initialize(name)
#     @name = name
#   end

#   private

#   def gait
#     "runs"
#   end
# end

# mike = Person.new("Mike")
# mike.walk
# # => "Mike strolls forward"

# kitty = Cat.new("Kitty")
# kitty.walk
# # => "Kitty saunters forward"

# flash = Cheetah.new("Flash")
# flash.walk
# # => "Flash runs forward"


################################

# noble.rb

module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  attr_reader :name
  include Walkable

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :name, :title
  include Walkable

  def initialize(name, title)
    @name = name
    @title = title
  end

  def name
    @title + " " + @name
  end

  private

  def gait
    "struts"
  end
end

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"
