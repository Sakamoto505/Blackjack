# frozen_string_literal: true

class Player
  attr_accessor :cards, :points, :name, :money

  def initialize(name)
    @points = 0
    @money = 100
    @cards = []
    @name = name
  end

  def give_cards
    @cards = []
  end

  #-----------------------------------

  def show_player_balance(balance)
    puts "Ваш баланс: #{balance}"
  end

  def add_cards(cards)
    (@cards << cards).flatten!
  end
end
