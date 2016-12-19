require "rubygems"
gem "mocha"
require "minitest"
require "minitest/autorun"
require "mocha/mini_test"
require "./lib/human_player"
require "stringio"

class HumanPlayerTest < Minitest::Test

  def setup
    @human_player = HumanPlayer.new
  end

  def test_human_player_inherits_from_player
    refute @human_player.ships_placed?
  end

  def test_player_can_place_ships
    @human_player.place_ships

    assert @human_player.ships_placed?
  end

  def test_player_can_fire
    @human_player.place_ships
    @human_player.fire("A1")
    @human_player.fire("A2")
    @human_player.fire("B1")
    @human_player.fire("B2")
    @human_player.fire("B3")

    assert @ship.destroyed?
  end
end
