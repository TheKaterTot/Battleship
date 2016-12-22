require "./lib/player"

class ComputerPlayer < Player

  def place_ships
    until @small_ship_placed
      small_first, small_second = small_ship_combos.sample
      @small_ship_placed = @ship_board.place_small_ship(small_first, small_second)
    end
    until @large_ship_placed
      large_first, large_second = large_ship_combos.sample
      @large_ship_placed = @ship_board.place_large_ship(large_first, large_second)
    end
    Message.computer_place_ships
  end

  def small_ship_combos
    [
      ["A1", "A2"], ["A2", "A3"], ["A3", "A4"],
      ["B1", "B2"], ["B2", "B3"], ["B3", "B4"],
      ["C1", "C2"], ["C2", "C3"], ["C3", "C4"],
      ["D1", "D2"], ["D2", "D3"], ["D3", "D4"],
      ["A1", "B1"], ["B1", "C1"], ["C1", "D1"],
      ["A2", "B2"], ["B2", "C2"], ["C2", "D2"],
      ["A3", "B3"], ["B3", "C3"], ["C3", "D3"],
      ["A4", "B4"], ["B4", "C4"], ["C4", "D4"]
    ]
  end

  def large_ship_combos
    [
      ["A1", "A3"], ["A2", "A4"],
      ["B1", "B3"], ["B2", "B4"],
      ["C1", "C3"], ["C2", "C4"],
      ["D1", "D3"], ["D2", "D4"],
      ["A1", "C1"], ["B1", "D1"],
      ["A2", "C2"], ["B2", "D2"],
      ["A3", "C3"], ["B3", "D3"],
      ["A4", "C4"], ["B4", "D4"],
    ]
  end

  def target_options
    first = ("A".."D").to_a.sample
    second = (1..4).to_a.sample
    first + second.to_s
  end

  def fire_weapons
    target = target_options
    target_valid = false
    until target_valid
      if !@ship_board.target_is_on_board?(target)
        target = target_options
      elsif @ship_board.target_is_repeat?(target)
        target = target_options
      else
        target_valid = true
        increases_shots
      end
    end
    Message.report_target(target)
    target
  end
end
