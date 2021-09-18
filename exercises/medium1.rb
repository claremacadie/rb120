# medium1.rb

# Q10

class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @deck.empty?
    @deck.pop
  end

  private

  def reset
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  attr_reader :deck
  attr_accessor :hand

  def initialize(deck)
    @deck = deck
    @hand = []
    deal_hand
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def deal_hand
    5.times { hand << deck.draw }
  end

  def royal_flush?
    straight_flush? && royal?
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    count_ranks.include?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    suits.uniq.size == 1
  end

  def straight?
    first_card_rank = sorted_hand[0].rank
    first_card_index = Deck::RANKS.index(first_card_rank)
    straight_ranks = Deck::RANKS[first_card_index..(first_card_index + 4)]

    ranks == straight_ranks
  end

  def three_of_a_kind?
    count_ranks.include?(3)
  end

  def two_pair?
    count_ranks.count(2) == 2
  end

  def pair?
    count_ranks.count(2) == 1
  end

  def count_ranks
    ranks.uniq.each_with_object([]) do |rank, counts|
      counts << ranks.count(rank)
    end
  end

  def ranks
    sorted_hand.each_with_object([]) do |card, ranks|
      ranks << card.rank
    end
  end

  def suits
    hand.each_with_object([]) do |card, suits|
      suits << card.suit
    end
  end

  def sorted_hand
    hand.sort
  end

  def royal?
    ranks == Deck::RANKS[8..12]
  end
end

# hand = PokerHand.new(Deck.new)
# hand.print
# puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

# Q9

# class Card
#   include Comparable
#   attr_reader :rank, :suit

#   VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def value
#     VALUES.fetch(rank, rank)
#   end

#   def <=>(other_card)
#     value <=> other_card.value
#   end
# end

# class Deck
#   attr_accessor :cards
#   RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
#   SUITS = %w(Hearts Clubs Diamonds Spades).freeze

#   def initialize
#     @cards = []
#     reset_deck
#   end

#   def draw
#     if cards.empty?
#       reset_deck
#       cards.pop
#     else
#       cards.pop
#     end
#   end

#   def reset_deck
#     RANKS.each do |rank|
#       SUITS.each do |suit|
#         cards << Card.new(rank, suit)
#       end
#     end
#     cards.shuffle!
#   end
# end


# deck = Deck.new
# drawn = []
# 52.times { drawn << deck.draw }
# puts drawn.count { |card| card.rank == 5 } == 4
# puts drawn.count { |card| card.suit == 'Hearts' } == 13

# drawn2 = []
# 52.times { drawn2 << deck.draw }
# puts drawn != drawn2 # Almost always.


# Q8

# class Card
#   include Comparable

#   RANK_ORDER = (2..10).to_a + ['Jack', 'Queen', 'King', 'Ace']
#   SUIT_ORDER = ['Diamonds', 'Clubs', 'Hearts', 'Spades']

#   attr_reader :rank, :suit

#   def initialize(rank, suit)
#     @rank = rank
#     @suit = suit
#   end

#   def to_s
#     "#{rank} of #{suit}"
#   end

#   def <=>(other)
#     if rank != other.rank
#       RANK_ORDER.index(rank) <=> RANK_ORDER.index(other.rank)
#     else
#       SUIT_ORDER.index(suit) <=> SUIT_ORDER.index(other.suit)
#     end
#   end
# end

# cards = [Card.new(2, 'Hearts'),
#         Card.new(10, 'Diamonds'),
#         Card.new('Ace', 'Clubs')]
# puts cards
# puts cards.min == Card.new(2, 'Hearts')
# puts cards.max == Card.new('Ace', 'Clubs')

# cards = [Card.new(5, 'Hearts')]
# puts cards.min == Card.new(5, 'Hearts')
# puts cards.max == Card.new(5, 'Hearts')

# cards = [Card.new(4, 'Hearts'),
#         Card.new(4, 'Diamonds'),
#         Card.new(10, 'Clubs')]
# puts cards.min.rank == 4
# puts cards.max == Card.new(10, 'Clubs')

# cards = [Card.new(7, 'Diamonds'),
#         Card.new('Jack', 'Diamonds'),
#         Card.new('Jack', 'Spades')]
# puts cards.min == Card.new(7, 'Diamonds')
# puts cards.max.rank == 'Jack'

# cards = [Card.new(8, 'Diamonds'),
#         Card.new(8, 'Clubs'),
#         Card.new(8, 'Spades')]
# puts cards.min
# puts cards.max

# Q7

# Number of guesses
# Math.log2(size_of_range).to_i + 1

# class GuessingGame
#   attr_reader :range, :max_guesses

#   RESULT_OF_GUESS_MESSAGE = {
#     high:  "Your number is too high.",
#     low:   "Your number is too low.",
#     match: "That's the number!"
#   }.freeze

#   WIN_OR_LOSE = {
#     high:  :lose,
#     low:   :lose,
#     match: :win
#   }.freeze

#   RESULT_OF_GAME_MESSAGE = {
#     win:  "You won!",
#     lose: "You have no more guesses. You lost!"
#   }.freeze

#   def initialize(min, max)
#     @range = min..max
#     @max_guesses = Math.log2(range.size).to_i + 1
#     @secret_number = nil
#   end

#   def play
#     reset
#     game_result = play_game
#     display_game_end_message(game_result)
#   end

#   private

#   def reset
#     @secret_number = rand(range)
#   end

#   def play_game
#     result = nil
#     max_guesses.downto(1) do |remaining_guesses|
#       display_guesses_remaining(remaining_guesses)
#       result = check_guess(obtain_one_guess)
#       puts RESULT_OF_GUESS_MESSAGE[result]
#       break if result == :match
#     end
#     WIN_OR_LOSE[result]
#   end

#   def display_guesses_remaining(remaining)
#     puts
#     if remaining == 1
#       puts 'You have 1 guess remaining.'
#     else
#       puts "You have #{remaining} guesses remaining."
#     end
#   end

#   def obtain_one_guess
#     loop do
#       print "Enter a number between #{range.first} and #{range.last}: "
#       guess = gets.chomp.to_i
#       return guess if range.cover?(guess)
#       print "Invalid guess. "
#     end
#   end

#   def check_guess(guess_value)
#     return :match if guess_value == @secret_number
#     return :low if guess_value < @secret_number
#     :high
#   end

#   def display_game_end_message(result)
#     puts "", RESULT_OF_GAME_MESSAGE[result]
#   end
# end

# game = GuessingGame.new(501, 1500)
# game.play

# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 104
# Invalid guess. Enter a number between 501 and 1500: 1000
# Your guess is too low.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 1250
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 1375
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 80
# Invalid guess. Enter a number between 501 and 1500: 1312
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 1343
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 1359
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 1351
# Your guess is too high.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 1355
# That is the number!

# You won!

# game.play
# You have 10 guesses remaining.
# Enter a number between 501 and 1500: 1000
# Your guess is too high.

# You have 9 guesses remaining.
# Enter a number between 501 and 1500: 750
# Your guess is too low.

# You have 8 guesses remaining.
# Enter a number between 501 and 1500: 875
# Your guess is too high.

# You have 7 guesses remaining.
# Enter a number between 501 and 1500: 812
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 501 and 1500: 843
# Your guess is too high.

# You have 5 guesses remaining.
# Enter a number between 501 and 1500: 820
# Your guess is too low.

# You have 4 guesses remaining.
# Enter a number between 501 and 1500: 830
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 501 and 1500: 835
# Your guess is too low.

# You have 2 guesses remaining.
# Enter a number between 501 and 1500: 836
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 501 and 1500: 837
# Your guess is too low.

# You have no more guesses. You lost!

# Q6

# class GuessingGame
#   attr_accessor :guesses, :guess, :game_end
#   attr_reader :number

#   MIN = 1
#   MAX = 100

#   def initialize
#     @guesses = 7
#     @number = rand(MIN..MAX)
#   end

#   def play
#     system 'clear'
#     loop do
#       puts "You have #{guesses} guesses remaining."
#       print "Enter a number between #{MIN} and #{MAX}: "
#       self.guess = gets.strip
#       compare_guess if validate_guess
#       break if game_end
#     end
#   end

#   def validate_guess
#     if !integer?(guess)
#       print "Invalid guess, that is not a number. Enter a number between #{MIN} and #{MAX}: "
#     elsif guess.to_i > MAX || guess.to_i < MIN
#       print "Invalid guess. Enter a number between #{MIN} and #{MAX}: "
#     else
#       true
#     end
#   end

#   def compare_guess
#     if guess.to_i == number
#       puts "That is the number!"
#       puts
#       puts "You won!"
#       self.game_end = true
#     elsif guess.to_i < number
#       puts "Your guess is too low."
#     else
#       puts "Your guess is too high."
#     end
#     puts
#     self.guesses -= 1

#     if guesses <= 0
#       puts "You have no more guesses. You lost!"
#       self.game_end = true
#     end
#   end

#   def integer?(input)
#     input == input.to_i.to_s
#   end
# end

# game = GuessingGame.new
# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That is the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!

# Q5

# class ValidateTokenError < StandardError; end

# class ValidateStackError < StandardError; end

# class Minilang
#   attr_accessor :stack, :register, :commands

#   COMMANDS = %w(PRINT PUSH ADD SUB MULT DIV MOD POP)

#   def initialize(commands)
#     @stack = []
#     @register = 0
#     @commands = commands.split(" ")
#   end

#   def eval
#     commands.each do |command|
#       if integer?(command)
#         self.register = command.to_i
#       else
#         validate_token(command)
#         send(command.downcase)
#       end
#     end

#     if commands.none? { |command| command == "PRINT" }
#       puts "(nothing printed; no PRINT commands)"
#     end
#   end

#   def integer?(str)
#     str == str.to_i.to_s
#   end

#   def print
#     puts register
#   end

#   def push
#     stack << register
#   end

#   def add
#     self.register += stack.pop
#   end

#   def sub
#     self.register -= stack.pop
#   end

#   def mult
#     self.register *= stack.pop
#   end

#   def div
#     self.register /= stack.pop
#   end

#   def mod
#     self.register %= stack.pop
#   end

#   def pop
#     validate_stack
#     self.register = stack.pop
#   end

#   def validate_token(token)
#     raise ValidateTokenError, "Invalid token: #{token}" unless COMMANDS.include?(token)
#   end

#   def validate_stack
#     raise ValidateStackError, "Empty stack!" if @stack.empty?
#   end
# end


# Minilang.new('PRINT').eval
# # 0

# Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

# Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

# Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

# # Minilang.new('5 PUSH POP POP PRINT').eval
# # Empty stack!

# Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# # 6

# Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# # 12

# # Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# # Invalid token: XSUB

# Minilang.new('-3 PUSH 5 SUB PRINT').eval
# # 8

# Minilang.new('6 PUSH').eval
# # (nothing printed; no PRINT commands)

# Q4

# class CircularQueue
#   attr_accessor :size, :queue
#   def initialize(size)
#     @size = size
#     @queue = Array.new(size)
#   end

#   def dequeue
#     queue << nil
#     queue.shift
#   end

#   def enqueue(new_item)
#     if queue.none?(&:nil?)
#       queue.shift
#       queue << new_item
#       return
#     end

#     0.upto(size - 1) do |idx|
#       if queue[idx] == nil
#         queue[idx] = new_item
#         return
#       end
#     end
#   end
# end

# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# Q3

# class Student
#   def initialize(name, year)
#     @name = name
#     @year = year
#   end
# end

# class Graduate < Student
#   def initialize(name, year, parking)
#     @parking = parking
#     super(name, year)
#   end
# end

# class Undergraduate < Student
# end

# Q2

# class FixedArray
#   attr_accessor :array, :size

#   def initialize(size)
#     @array =[]
#     @size = size
#     size.times {array << nil}
#   end

#   def [](idx)
#     array.fetch(idx)
#   end

#   def []=(idx, value)
#     self[idx]
#     array[idx] = value
#   end

#   def to_s
#     array.to_s
#   end

#   def to_a
#     array
#   end
# end


# fixed_array = FixedArray.new(5)
# puts fixed_array[3] == nil
# puts fixed_array.to_a == [nil] * 5

# fixed_array[3] = 'a'
# puts fixed_array[3] == 'a'
# puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

# fixed_array[1] = 'b'
# puts fixed_array[1] == 'b'
# puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

# fixed_array[1] = 'c'
# puts fixed_array[1] == 'c'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

# fixed_array[4] = 'd'
# puts fixed_array[4] == 'd'
# puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
# puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

# puts fixed_array[-1] == 'd'
# puts fixed_array[-4] == 'c'

# begin
#   fixed_array[6]
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[-7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# begin
#   fixed_array[7] = 3
#   puts false
# rescue IndexError
#   puts true
# end

# Q1

# class Machine
#   def start
#     flip_switch(:on)
#   end

#   def stop
#     flip_switch(:off)
#   end

#   def retrieve_switch
#     switch
#   end

#   private

#   attr_accessor :switch

#   def flip_switch(desired_state)
#     self.switch = desired_state
#   end
# end