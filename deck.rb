# frozen_string_literal: true

class Deck
  attr_reader :cards, :suits

  def initialize
    @cards = []
    create_deck
  end

  def take_cards(count: 1)
    cards.pop(count)
  end

  def create_deck
    Card::SUITS.each do |suit|
      Card::VALUES.each_with_index do |value, index|
        @cards << Card.new(suit, value, Card::RANKS[index])
      end
    end
    @cards.shuffle!
  end
end
