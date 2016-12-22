require "./test/test_helper"
require "./lib/board"
require "stringio"

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
  end

  def with_stdio
    stdin = $stdin
    $stdin, input = IO.pipe
    stdout = $stdout
    output, $stdout = IO.pipe
    yield input, output
    input.close
    $stdin = stdin
    output.close
    $stdout = stdout
  end

  def test_draws_ship_board
      with_stdio do |input, output|
        @board.draw_ship_board

        assert_equal "===========\n", output.gets
      end
  end

  def test_draws_shots_fired_board
      with_stdio do |input, output|
        @board.draw_shots_fired_board

        assert_equal "===========\n", output.gets
      end
  end

  def test_ship_board_holds_small_ships
    @board.place_small_ship("A2", "A3")

    assert_equal "*", @board.ship_board[1][2]
    assert_equal "*", @board.ship_board[1][3]
  end

  def test_player_can_place_large_ship
    @board.place_large_ship("A2", "A4")

    assert_equal "$", @board.ship_board[1][2]
    assert_equal "$", @board.ship_board[1][3]
    assert_equal "$", @board.ship_board[1][4]
  end

  def test_ship_coordinates_are_contiguous
    @board.place_small_ship("A2", "D4")

    assert_equal " ", @board.ship_board[1][2]
    assert_equal " ", @board.ship_board[4][4]
  end

  def test_ship_cannot_be_placed_over_ship
    @board.place_small_ship("A1", "A2")
    @board.place_small_ship("A2", "A3")

    assert_equal " ", @board.ship_board[1][3]
  end

  def test_finds_middle
    assert_equal [2, 2], @board.find_large_ship_middle("A2", "C2")
  end

  def test_large_ship_cannot_be_placed_over_ship
    @board.place_large_ship("B1", "B3")
    @board.place_large_ship("A2", "C2")

    assert_equal " ", @board.ship_board[3][2]
  end

  def test_finds_large_ship_middle
    @board.place_large_ship("A4", "C4")

    assert_equal "$", @board.ship_board[2][4]
  end
end
