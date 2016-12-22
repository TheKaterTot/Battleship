require "./test/test_helper"
require "./lib/computer_player"
require "stringio"

class ComputerPlayerTest < Minitest::Test
  def setup
    @computer_player = ComputerPlayer.new
  end

  def test_computer_can_place_ships
    @computer_player.expects(:small_ship_combos).returns([["A1", "A2"]])
    @computer_player.place_ships

    assert_equal "*", @computer_player.ship_board.find_board_location("A1")
  end

  def test_player_can_fire
    @computer_player.place_small_ship("A1", "A2")
    @computer_player.fired_at("A1")
    @computer_player.fired_at("A2")

    assert @computer_player.ship_1.destroyed?
  end
end
