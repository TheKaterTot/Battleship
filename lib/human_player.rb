require "./lib/player"

class HumanPlayer < Player

  def get_coordinates
    gets.chomp.split(" ")
  end

  def place_ships
    until @small_ship_placed
      puts "Place your small ship"
      small_first, small_second = get_coordinates
      @small_ship_placed = @ship_board.place_small_ship(small_first, small_second)
    end
    @ship_board.draw_ship_board
    until @large_ship_placed
      puts "Place your large ship"
      large_first, large_second = get_coordinates
      @large_ship_placed = @ship_board.place_large_ship(large_first, large_second)
    end
    @ship_board.draw_ship_board
  end

  def fire_weapons
    Message.fire_weapons
    gets.chomp
  end
end
