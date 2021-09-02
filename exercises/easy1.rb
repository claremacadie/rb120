# easy1.rb

# banner_class

# Problem
# Create a method that takes and string and an integer and returns the message in a box.

# Assumptions
# If the integer is < 4, output error message
# If integer is < message.size - 4, wrap the message over several lines

# Data
# Input = string and integer
# Output = series of strings

# Algorithm
# Return error message if width < 4
# horizontal line and empty line should use width, rather than size

# Sub-class: Create array of message lines
# Create empty array for message lines
# Create array of words from message
# Initialize variable line = ''
# Iterate through words in array
    # if line.size + word.size + 1 < @width
        # append space then word to line
    # else
        # centre line to width
        # append line to message lines array
        # set line to ''
# Return message lines array

# class Banner

#   def initialize(message, width = 0)
#     @message = message
#     @width = assign_width(width)
#   end

#   def to_s
#     "I'm to_s"
#     [horizontal_rule, empty_line, message_lines, empty_line, horizontal_rule].flatten.join("\n")
#   end

#   private

#   def assign_width(width)
#     if width < 4
#       puts "The specified width must be at least 10."
#       exit # This exits program entirely, rather than just terminating this invocation of method.
#     elsif @message.size < width - 4
#       @message.size + 4
#     else
#       width
#     end
#   end

#   def horizontal_rule
#     "+" + '-' * (@width - 2) + "+"
#   end

#   def empty_line
#     "|" + ' ' * (@width - 2) + "|"
#   end

#   def message_lines
#     message_lines = []
#     words = @message.split(' ')
#     line = ''
#     words.each do |word|
#       if line.empty?
#         line << word
#         next
#       end
#       if (line.size + 1 + word.size) <= (@width - 4)
#         line << ' ' + word
#       else
#         centred_line = '|' + line.center(@width - 2) + '|'
#         message_lines << centred_line
#         line = ''
#         line << word
#       end
#     end
#     unless line.empty?
#       centred_line = '|' + line.center(@width - 2) + '|'
#       message_lines << centred_line
#     end
#     message_lines
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.', 42)
# puts banner

# banner = Banner.new('To boldly go where no one has gone before. The quick brown fox jumped over the lazy dog.', 20)
# puts banner

# banner = Banner.new('')
# puts banner

# banner = Banner.new('Forever.', 60)
# puts banner

###############################################
# what's_the_output.rb

# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s
#   end

#   def to_s
#     #@name.upcase!
#     "My name is #{@name.upcase}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name

# name = 42
# fluffy = Pet.new(name)
# name += 1
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name


########################################
# book.rb (part 1)

# class Book
#   attr_reader :author, :title
#   def initialize(author, title)
#     @author = author
#     @title = title
#   end

#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new("Neil Stephenson", "Snow Crash")
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)


##################################
# book.rb (part 2)

# class Book
#   attr_accessor :author, :title
#   def to_s
#     %("#{title}", by #{author})
#   end
# end

# book = Book.new
# book.author = "Neil Stephenson"
# book.title = "Snow Crash"
# puts %(The author of "#{book.title}" is #{book.author}.)
# puts %(book = #{book}.)


#################################
# person.rb

# class Person
#   def initialize(first_name = '', last_name = '')
#     @first_name = first_name.capitalize
#     @last_name = last_name.capitalize
#   end

#   def first_name= (value)
#     @first_name = value.capitalize
#   end

#   def last_name= (value)
#     @last_name = value.capitalize
#   end

#   def to_s
#     "#{@first_name} #{@last_name}"
#   end
# end

# person = Person.new('john', 'doe')
# puts person

# person.first_name = 'jane'
# person.last_name = 'smith'
# puts person


##########################
# flight.rb

# class Flight

#   def initialize(flight_number)
#     @database_handle = Database.init
#     @flight_number = flight_number
#   end
# end


##############################
# car.rb

# class Car
#   attr_accessor :mileage

#   def initialize
#     @mileage = 0
#   end

#   def increment_mileage(miles)
#     total = mileage + miles
#     self.mileage = total
#   end

#   def print_mileage
#     puts mileage
#   end
# end

# car = Car.new
# car.mileage = 5000
# car.increment_mileage(678)
# car.print_mileage  # should print 5678


##################################
# rectangle.rb

# class Rectangle
#   def initialize(height, width)
#     @height = height
#     @width = width
#   end

#   def area
#     @height * @width
#   end
# end

# class Square < Rectangle
#   def initialize(length_of_side)
#     super(length_of_side, length_of_side)
#   end
# end

# square = Square.new(5)
# puts "area of square = #{square.area}"


####################################
# pet.rb

# class Pet
#   def initialize(name, age)
#     @name = name
#     @age = age
#   end
# end

# class Cat < Pet
#   attr_accessor :name, :age, :colors
#   def initialize(name, age, colors)
#     super(name, age)
#     @colors = colors
#   end

#   def to_s
#     "My cat #{name} is #{age} years old and has #{colors} fur."
#   end
# end

# pudding = Cat.new('Pudding', 7, 'black and white')
# butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
# puts pudding, butterscotch


####################################
# car.rb

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

