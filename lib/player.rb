require "./lib/ship"

class Player
  attr_reader :ship_1, :ship_2, :player_ships
  def initialize
    @ship_1 = Ship.new(2)
    @ship_2 = Ship.new(3)
    @ships_placed = false
    @player_ships = [[".", 1, 2, 3, 4],
            ["A", " ", " ", " ", " "],
            ["B", " ", " ", " ", " "],
            ["C", " ", " ", " ", " "],
            ["D", " ", " ", " ", " "]]

    @shots_fired = [[".", 1, 2, 3, 4],
            ["A", " ", " ", " ", " "],
            ["B", " ", " ", " ", " "],
            ["C", " ", " ", " ", " "],
            ["D", " ", " ", " ", " "]]
  end

  def draw_board
    puts "==========="
    @shots_fired.each do |row|
       puts row.join(" ")
    end
    puts "==========="
  end

  def ships_placed
    @ships_placed = true
  end

  def ships_placed?
    @ships_placed
  end

  def row(letter)
    {"A" => 1, "B" => 2, "C" => 3, "D" => 4}[letter]
  end

  def place_small_ship(x, y)
    x = x.chars
    y = y.chars
    if @player_ships[row(x[0])][x[1].to_i] == "*" || @player_ships[row(y[0])][y[1].to_i]  == "*"
      puts "You already have a ship here. Try again."
    else
      if (row(x[0]) - row(y[0])).abs == 1
        if (x[1].to_i - y[1].to_i).abs == 0
          @player_ships[row(x[0])][x[1].to_i] = "*"
          @player_ships[row(y[0])][y[1].to_i] = "*"
        end
      elsif (row(x[0]) - row(y[0])).abs == 0
        if (x[1].to_i - y[1].to_i).abs == 1
          @player_ships[row(x[0])][x[1].to_i] = "*"
          @player_ships[row(y[0])][y[1].to_i] = "*"
        end
      end
    end
  end

  def place_large_ship(x, y)
    x = x.chars
    y = y.chars
    if (row(x[0]) - row(y[0])).abs == 2
      if (x[1].to_i - y[1].to_i).abs == 0
        @player_ships[row(x[0])][x[1].to_i] = "*"
        @player_ships[row(y[0])][y[1].to_i] = "*"
        @player_ships[(row(y[0]) - row(x[0]) / 2) + x[0].to_i][(y[1].to_i)] = "*"
      end
    elsif (row(x[0]) - row(y[0])).abs == 0
      if (x[1].to_i - y[1].to_i).abs == 2
        @player_ships[row(x[0])][x[1].to_i] = "*"
        @player_ships[row(y[0])][y[1].to_i] = "*"
        @player_ships[row(y[0])][((x[1].to_i - y[1].to_i) / 2) + y[1].to_i] = "*"
      end
    end
  end
end
