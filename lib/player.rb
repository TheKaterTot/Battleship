require "./lib/ship"
require "./lib/board"

class Player
  attr_reader :ship_1, :ship_2, :ship_board
  def initialize
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @small_ship_placed = false
    @large_ship_placed = false
    @ship_board = Board.new
    @shots_fired_board = Board.new
  end

  def place_small_ship(x, y)
    @ship_board.place_small_ship(x, y)
  end

  def place_large_ship(x, y)
    @ship_board.place_large_ship(x, y)
  end

  def fired_at(coordinate)
    if @ship_board.find_board_location(coordinate) == "*"
      @ship_1.hit
      @ship_1.destroyed
      true
    elsif @ship_board.find_board_location(coordinate) == "$"
      @ship_2.hit
      @ship_2.destroyed
      true
    else
      false
    end
  end

end
