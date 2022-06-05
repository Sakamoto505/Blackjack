# frozen_string_literal: true

class Crop
  attr_accessor :points, :cards, :money

  def initialize
    @points = 0
    @cards = []
    @money = 100
  end

  def add_cards(cards)
    (@cards << cards).flatten!
  end

  def give_cards
    @cards = []
  end
end
