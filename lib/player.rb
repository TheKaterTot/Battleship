require "./lib/ship"
require "./lib/board"
require "paint"

class Player
  attr_reader :ship_1, :ship_2, :ship_board, :shots_fired_board, :number_of_shots
  def initialize
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @small_ship_placed = false
    @large_ship_placed = false
    @ship_board = Board.new
    @shots_fired_board = Board.new
    @number_of_shots = 0
  end

  def increases_shots
    @number_of_shots += 1
  end

  def place_small_ship(x, y)
    @ship_board.place_small_ship(x, y)
  end

  def place_large_ship(x, y)
    @ship_board.place_large_ship(x, y)
  end

  def draw_board
    ship_board.draw_shots_fired_board
  end

  def track_hit(target)
    ship_board.track_shots_fired(target, Paint["H", :red, :bright])
  end

  def track_miss(target)
    ship_board.track_shots_fired(target, Paint["M", :blue, :bright  ])
  end

  def fired_at(coordinate)
    if @ship_board.find_board_location(coordinate) == "*"
      @ship_1.hit
      if @ship_1.destroyed?
        Message.small_ship_dead
      end
      true
    elsif @ship_board.find_board_location(coordinate) == "$"
      @ship_2.hit
      if @ship_2.destroyed?
        Message.large_ship_dead
      end
      true
    else
      false
    end
  end

  def destroyed?
    ship_1.destroyed? && ship_2.destroyed?
  end

  def end_turn

  end

  def overlay(other_player)
    ship_board.overlay(other_player.ship_board)
  end

end
