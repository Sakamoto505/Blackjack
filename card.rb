# frozen_string_literal: true

class Card
  attr_reader  :rank, :suit, :value

  SUITS = %i[♣ ♦ ♥ ♠].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, :j, :Q, :K, :A].freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, [1, 11]].freeze

  def initialize(suit, value, rank)
    @suit = suit
    @value = value
    @rank = rank
  end

  def self.calculate_points(user)
    user.cards.map do |card|
      count = 0
      count += card.rank if (2..10).include? card.value
      count += 10 if %w[J Q K].include? card.value.to_s
      count += 11 if (%w[A].include? card.value.to_s) && ((user.points + 11 + count) < 21)
      count += 1 if %w[A].include? card.value.to_s
      count
    end.sum
  end

  def ace?
    @rank == 'A'
  end
end
