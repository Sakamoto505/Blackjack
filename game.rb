# frozen_string_literal: true

class Game
  attr_accessor :bank

  def next_step(user)
    open_cards if need_open?
    if user.is_a?(Player)
      player_move
    else
      crop_move
    end
  end

  def initialize(player:, crop:)
    @deck = Deck.new
    @player = player
    @crop = crop

    crop.give_cards
    crop.add_cards(@deck.take_cards(count: 2))
    @crop.points = Card.calculate_points(@crop)

    player.give_cards
    player.add_cards(@deck.take_cards(count: 2))
    @player.points = Card.calculate_points(@player)

    next_step(@player)
  end

  def need_open?
    if @crop.cards.size > 2 && @player.cards.size > 2
      true
    else
      false
    end
  end

  def open_cards
    if (@player.points > @crop.points && @player.points <= 21) ||
       (@player.points < @crop.points && @player.points >= 21)
      player_win
    elsif (@crop.points > @player.points) && @crop.points < 21
      crop_win
    else
      puts 'Ничья'
    end

    puts '1. Хотите продолжить игру'
    puts '2. Выход'
    case gets.chomp.to_i
    when 1 then self.class.new(player: @player, crop: @crop)
    when 2 then exit
    else
      exit
    end
  end

  def player_move
    player_info
    hidden_crop_info
    puts '1 Пропустить ход'
    puts '2 Добавить одну карту'
    puts '3 Вскрыть карты'

    case gets.chomp.to_i
    when 1 then next_step(@crop)
    when 2 then add_one_card(@player)
    when 3 then open_cards
    end

    next_step(@crop)
  end

  def add_one_card(user)
    user.add_cards(@deck.take_cards)
    recalculated_points = Card.calculate_points(user)
    user.points = recalculated_points
  end

  def crop_move
    if @crop.points > 17
      puts 'Компьютер пропустил ход'
    else
      add_one_card(@crop)
      puts 'Компьютер взял карту'
    end
    next_step(@player)
  end

  def player_info
    puts '----Информация----'
    puts "Игрок: #{@player.name}. Количество очков: #{@player.points}"
    (@player.cards.map { |card| puts "Карта: #{card.value} #{card.suit}" }).join(' ')

    puts "Сумма на руках: #{@player.money}"

    puts '==================='
  end

  def hidden_crop_info
    puts 'Крупье. Количество очков: *'
    @crop.cards.map { |_card| puts 'Карта: * *' }

    puts 'Сумма на руках: *'
    puts '==================='
  end

  def crop_info
    puts "Крупье. Количество очков: #{@crop.points}" unless (@crop.points) > 21
    @crop.cards.map { |card| puts "Карта: #{card.value} #{card.suit}" }

    puts "Сумма на руках: #{@crop.money}"
    puts '==================='
  end


  def crop_win
    self.class.give_money(winner: @crop, loser: @player)

    puts "Вы проиграли, счет крупье: #{@crop.points}"
    crop_info
    player_info
  end

  def player_win
    self.class.give_money(winner: @player, loser: @crop)

    puts "Уважаемый #{@player.name} вы победили"
    player_info
    crop_info
  end

  def self.give_money(winner:, loser:)
    winner.money += 10

    loser.money -= 10
  end
end
