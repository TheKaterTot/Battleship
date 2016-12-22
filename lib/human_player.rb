require "./lib/player"

class HumanPlayer < Player

  def get_coordinates
    gets.chomp.split(" ")
  end

  def place_ships
    until @small_ship_placed
      Message.place_small_ship
      small_first, small_second = get_coordinates
      @small_ship_placed = @ship_board.place_small_ship(small_first, small_second)
    end
    @ship_board.draw_ship_board
    until @large_ship_placed
      Message.place_large_ship
      large_first, large_second = get_coordinates
      @large_ship_placed = @ship_board.place_large_ship(large_first, large_second)
    end
    @ship_board.draw_ship_board
  end

  def fire_weapons
    Message.fire_weapons
    target = gets.chomp
    target_valid = false
    until target_valid
      if !@ship_board.target_is_on_board?(target)
        Message.fire_weapons_again
        target = gets.chomp
      elsif @ship_board.target_is_repeat?(target)
        Message.target_is_repeat
        target = gets.chomp
      else
        target_valid = true
      end
    end
    target
  end

  def end_turn
    Message.end_turn
    gets
  end
end
