# GoodDog.rb

class GoodDog
  DOG_YEARS = 7
  @@number_of_dogs = 0

  attr_accessor :name, :age

  def initialize(n, a)
    self.name = n
    self.age = a
    @@number_of_dogs += 1
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def speak(word)
    "#{name} says #{word}"
  end

  def change_info(n, a)
    self.name = n
    self.age = a
  end

  def info
    "#{self.name} is aged #{self.age} in dog years."
  end

  def what_is_self
    self
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def to_s
    "This dog's name is #{name} and it is #{age} in dog years."
  end

  def public_disclosure
    "#{self.name} in human years is #{human_years}"
  end

  private

  def human_years
    age * DOG_YEARS
  end

end

# puts GoodDog.total_number_of_dogs
# dog1 = GoodDog.new("1", 1)
# dog2 = GoodDog.new("2", 3)
# puts GoodDog.total_number_of_dogs


# # puts GoodDog.what_am_i

sparky = GoodDog.new("Sparky", 3)
p sparky.what_is_self
p sparky.public_disclosure