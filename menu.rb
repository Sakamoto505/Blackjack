# frozen_string_literal: true

class Menu
  require_relative 'card'
  require_relative 'crop'
  require_relative 'deck'
  require_relative 'game'
  require_relative 'player'
  require 'pry'

  def ask_name
    puts 'Как вас зовут'
    gets.chomp.to_s
  end

  def go
    loop do
      puts '1. Начать игру'
      puts '2. Выход'
      case gets.chomp.to_i
      when 1 then start_game(ask_name)
      when 2 then exit
      end
    end
  end

  def start_game(name)
    player = Player.new(name)
    crop = Crop.new

    Game.new(player: player, crop: crop)
  end
end

Menu.new.go
