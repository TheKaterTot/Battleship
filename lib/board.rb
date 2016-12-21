require "./lib/messages"

class Board
  attr_reader :ship_board, :shots_fired_board

  def initialize
    @ship_board = [[".", 1, 2, 3, 4],
            ["A", " ", " ", " ", " "],
            ["B", " ", " ", " ", " "],
            ["C", " ", " ", " ", " "],
            ["D", " ", " ", " ", " "]]
    @shots_fired_board = [[".", 1, 2, 3, 4],
            ["A", " ", " ", " ", " "],
            ["B", " ", " ", " ", " "],
            ["C", " ", " ", " ", " "],
            ["D", " ", " ", " ", " "]]
  end

  def draw_ship_board
    puts "==========="
    @ship_board.each do |row|
       puts row.join(" ")
    end
    puts "==========="
  end

  def draw_shots_fired_board
    puts "==========="
    @shots_fired_board.each do |row|
       puts row.join(" ")
    end
    puts "==========="
  end

   def row(letter)
     {"A" => 1, "B" => 2, "C" => 3, "D" => 4}[letter]
   end

   def find_board_location(location)
     letter, number = location.split("")
     @ship_board[row(letter)][number.to_i]
   end

   def check_location(row, column)
     @ship_board[row][column] != " "
   end

   def check_for_small_ship(x, y)
    check_location(row(x[0]), x[1].to_i) ||
    check_location(row(y[0]), y[1].to_i)
   end

   def check_for_big_ship(x, y)
     middle = find_large_ship_middle(x, y)
     if !middle.nil?
       check_location(row(x[0]), x[1].to_i) ||
       check_location(row(y[0]), y[1].to_i) ||
       check_location(middle[0], middle[1])
     end
   end

  def set(row, column, tile)
    @ship_board[row][column] = tile
  end

  def place(letter, number, tile)
    set(row(letter), number.to_i, tile)
  end

  def small_ship_valid?(x, y)
    ((row(x[0]) - row(y[0])).abs == 1 && (x[1].to_i - y[1].to_i).abs == 0) ||
    ((row(x[0]) - row(y[0])).abs == 0 && (x[1].to_i - y[1].to_i).abs == 1)
  end

  def place_small_ship(x, y)
    x = x.chars
    y = y.chars
    if check_for_small_ship(x, y)
      Message.ship_overlap
    else
      if small_ship_valid?(x, y)
        place(x[0], x[1], "*")
        place(y[0], y[1], "*")
        true
      else
        Message.ship_invalid
      end
    end
  end

  def large_ship_vertical_valid?(x, y)
    (row(x[0]) - row(y[0])).abs == 2 && (x[1].to_i - y[1].to_i).abs == 0
  end

  def large_ship_horizontal_valid?(x, y)
    (row(x[0]) - row(y[0])).abs == 0 && (x[1].to_i - y[1].to_i).abs == 2
  end

  def find_large_ship_middle(x, y)
    if large_ship_horizontal_valid?(x, y)
      [row(y[0]), ((x[1].to_i - y[1].to_i) / 2) + y[1].to_i]
    elsif large_ship_vertical_valid?(x, y)
      [(row(y[0]) - row(x[0])) / 2 + row(x[0]), y[1].to_i]
    end
  end

  def place_large_ship(x, y)
    x = x.chars
    y = y.chars
    if check_for_big_ship(x, y)
      Message.ship_overlap
    else
      if large_ship_vertical_valid?(x, y)
        place(x[0], x[1], "$")
        place(y[0], y[1], "$")
        set((row(y[0]) - row(x[0]) / 2) + x[0].to_i, y[1].to_i, "$")
        true
      elsif large_ship_horizontal_valid?(x, y)
        place(x[0], x[1], "$")
        place(y[0], y[1], "$")
        set(row(y[0]), ((x[1].to_i - y[1].to_i) / 2) + y[1].to_i, "$")
        true
      else
        Message.ship_invalid
      end
    end
  end

end