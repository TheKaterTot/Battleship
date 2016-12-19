require "rubygems"
gem "mocha"
require "minitest"
require "minitest/autorun"
require "mocha/mini_test"
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

  def test_player_has_board
      with_stdio do |input, output|
        @player.draw_board

        assert_equal "===========\n", output.gets
      end
  end

  def test_player_can_place_small_ship
    @player.place_small_ship("A2", "A3")

    assert_equal "*", @player.player_ships[1][2]
    assert_equal "*", @player.player_ships[1][3]
  end

  def test_player_can_place_large_ship
    @player.place_large_ship("A2", "A4")

    assert_equal "*", @player.player_ships[1][2]
    assert_equal "*", @player.player_ships[1][3]
    assert_equal "*", @player.player_ships[1][4]
  end

  def test_ship_coordinates_are_contiguous
    @player.place_small_ship("A2", "D4")

    assert_equal " ", @player.player_ships[1][2]
    assert_equal " ", @player.player_ships[4][4]
  end

  def test_ship_cannot_be_placed_over_ship
    @player.place_small_ship("A1", "A2")
    @player.place_small_ship("A2", "A3")

    assert_equal " ", @player.player_ships[1][3]
  end
end
