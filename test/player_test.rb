require "./test/test_helper"
require "./lib/player"
require "stringio"

class PlayerTest < Minitest::Test
  def setup
    @player = Player.new
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

  def test_player_has_two_ships
    assert_equal Ship, @player.ship_1.class
    assert_equal Ship, @player.ship_2.class
  end

  def test_player_can_place_small_ship
    @player.place_small_ship("A2", "A3")

    assert_equal "*", @player.ship_board.find_board_location("A2")
    assert_equal "*", @player.ship_board.find_board_location("A3")
  end

end
