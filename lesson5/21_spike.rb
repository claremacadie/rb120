# 21_spike.rb

class Card
  attr_reader :suit, :rank, :value
  def initialize
    set_suit
    set_rank
    set_value
  end
end

class Deck
  attr_accessor :cards
  def initialize
    create_52_card_obj
  end
end

class Hand
  attr_accessor :score, :cards

  def dealt_card
    deal_card_from_deck
  end

  def update_score
    determine_score_of_hand
  end
end

class Player
  attr_reader :name
  attr_accessor :hand

  def initialize
    set_name
    create_hand
  end
end

class TwentyOneGame
  attr_reader :human, :computer
  attr_accessor :deck

  def initialize
    @human
    @computer
    @deck
  end

  def play
    create_human_player
    create_computer_player
    display_welcome_message
    display_rules
    reset_and_shuffle_cards
    deal_two_cards_to_players
    human_turn
    computer_turn
    compare_hands
    declare_winner
    display_goodbye_message
  end
end

