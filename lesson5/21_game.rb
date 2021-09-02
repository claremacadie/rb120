# 21_game.rb

module Formattable
  def clear
    system('clear')
  end

  def blank_line
    puts
  end

  def joinor(arr, delimiter=', ', word='and')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(delimiter)
    end
  end
end

module Questionable
  include Formattable

  YES_NO_OPTIONS = %w(y yes n no)

  def ask_yes_no_question(question)
    answer = nil
    loop do
      puts question
      answer = gets.chomp.downcase.strip
      break if YES_NO_OPTIONS.include? answer
      puts "Sorry, must be y or n."
      blank_line
    end
    answer[0] == 'y'
  end

  def ask_open_question(question, void_answer)
    answer = nil
    loop do
      puts question
      answer = gets.chomp.strip
      break unless answer.empty? || answer == void_answer
      puts "Sorry, must enter a value (it can't be '#{void_answer}'!)."
      blank_line
    end
    answer
  end

  def ask_closed_question(question, options)
    downcase_options = options.map(&:downcase)
    answer = nil
    loop do
      puts question
      answer = gets.chomp.downcase.strip
      break if downcase_options.include?(answer)
      puts "Sorry, invalid choice."
      blank_line
    end
    answer
  end

  def ask_integer_choice(question, options)
    answer = nil
    loop do
      puts question
      answer = gets.chomp.strip
      break if options.include?(answer.to_i) && integer?(answer)
      puts "Sorry, that's not a valid choice, must be an integer."
      blank_line
    end
    answer.to_i
  end

  def integer?(str)
    str == str.to_i.to_s
  end
end

module Displayable
  include Formattable

  def display_welcome_message
    clear
    puts <<~WELCOME
    Hi #{player.name}. Welcome to Twenty-One!
    You are playing against #{dealer.name}.
    The first to win #{Game::WINS_LIMIT} games is the Champion!
    WELCOME
    blank_line
  end

  def display_hand(name, hand)
    puts "#{name} has #{joinor(hand.dup)}"
  end

  def display_result_and_scores
    display_result
    display_scores
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts <<~SCORES
    Remember, the first to win #{Game::WINS_LIMIT} games is the Champion!
    #{player.name} has #{player.score} #{player.point_string}.
    #{dealer.name} has #{dealer.score} #{dealer.point_string}.
    SCORES
  end


  def display_champion
    blank_line
    puts "#{champion} won #{Game::WINS_LIMIT} games and is the CHAMPION!"
    blank_line
  end

  def play_again?
    ask_yes_no_question("Would you like to play another match? (y/n)")
  end

  def continue_match_message
    blank_line
    answer = ask_closed_question(
      "Press enter to continue the match (or 'q' to quit this match).",
      ["", "q"]
    )
    clear
    answer.empty? ? true : false
  end

  def display_rematch_message
    clear
    puts <<~REMATCH
    Hi #{player.name}. Welcome back to Twenty-One!
    You are playing against #{dealer.name}.
    Remember, the first to win #{Game::WINS_LIMIT} games is the Champion!
    REMATCH
    blank_line
  end

  def display_goodbye_message
    puts "Thank you for playing Twenty-One! Goodbye!"
    blank_line
  end
end

class Participant
  include Displayable
  include Questionable

  DEALER_NAME = "Alice"

  attr_reader :name
  attr_accessor :hand

  # what goes in here? all the redundant behaviors from Player and Dealer?

  def initialize
    @hand = []
  end

  def deal_card(deck)
    hand << deck.cards.pop
  end

  def show_hand
     display_hand(name, hand)
  end

  def busted?
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Player < Participant
  def initialize
    @name = ask_open_question("What's your name?", DEALER_NAME)
    super
  end

  def hit
  end

  def stay
  end
end

class Dealer < Participant
  def initialize
    @name = DEALER_NAME
    super
  end

  def hit
  end

  def stay
  end
end

class Deck
  HEART = "\u2665"
  CLUB = "\u2663"
  DIAMOND = "\u2666"
  SPADE = "\u2660"

  CARD_SUITS = [HEART, CLUB, DIAMOND, SPADE]
  CARD_RANKS_AND_VALUES = {
    '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8,
    '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10, 'King' => 10, 'Ace' => 1
  }

  attr_accessor :cards

  def initialize
    reset
  end

  def deal
    # does the dealer or the deck deal?
  end

  def reset
    self.cards = CARD_SUITS.each_with_object([]) do |suit, arr|
    CARD_RANKS_AND_VALUES.keys.each do |rank|
      arr << Card.new(rank, suit)
    end
  end
  cards.shuffle!
  end
end

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank}#{suit}"
  end
end

class Game
  include Displayable
  include Questionable

  WINS_LIMIT = 5
  BUST_VALUE = 21
  DEALER_STICK_VALUE = 17
  ACE_VALUE_ALTERNATE = 10
  ACE_VALUE_LIMIT = 11

  attr_reader :player, :dealer
  attr_accessor :deck, :champion

  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
    @champion = nil
  end

  def start
    clear
    display_welcome_message
    loop do
      main_game
      display_champion if champion
      break unless play_again?
      reset_match
      display_rematch_message
    end
    display_goodbye_message
  end

  private

  def main_game
    loop do
      deal_cards
      display_initial_cards
      player_turn
      dealer_turn
      display_initial_cards
      display_result
      deck.reset
      break unless continue_match_message
    end
  end

  def deal_cards
    2.times do
      dealer.deal_card(deck)
      player.deal_card(deck)
    end
  end

  def display_initial_cards
    dealer.show_hand
    player.show_hand
  end

  def player_turn
    loop do
      choice = ask_closed_question(
        "Would you like to (h)it or (s)tay?", ['h', 's']
      )
      break if choice == 's'
      player.deal_card(deck)
      player.show_hand
    end
    puts "#{player.name} chose to stay."
  end

  def dealer_turn
    loop do
      dealer.deal_card(deck)
      dealer.show_hand
      break
    end
    puts "#{dealer.name} chose to stay."
  end

  def display_result

  end

  def display_champion
  end

  def play_again?
  end

  def reset_match
  end
end

Game.new.start