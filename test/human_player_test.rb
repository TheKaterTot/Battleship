require "./test/test_helper"
require "./lib/human_player"
require "stringio"

class HumanPlayerTest < Minitest::Test

  def setup
    @human_player = HumanPlayer.new
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

  def test_player_can_place_ships
    with_stdio do |input, ouput|
      input.puts "A1 A2"
      input.puts "B1 B3"

      @human_player.place_ships
    end
    assert_equal "$", @human_player.ship_board.find_board_location("B2")
  end

  def test_player_can_fire
    with_stdio do |input, output|
      input.puts "A1 A2"
      input.puts "B1 B3"
      @human_player.place_ships
    end
    @human_player.fired_at("A1")
    @human_player.fired_at("A2")
    @human_player.fired_at("B1")
    @human_player.fired_at("B2")
    @human_player.fired_at("B3")

    assert @human_player.ship_1.destroyed?
    assert @human_player.ship_2.destroyed?
  end

  def test_player_tracks_shots
    with_stdio do |input, output|
      input.puts "A1 A2"
      input.puts "B1 B3"
      input.puts "A2"
      @human_player.place_ships

      assert @human_player.fire_weapons
    end
  end

  def test_counts_shots
    with_stdio do |input, output|
      input.puts "A3"
      input.puts "B2"
      @human_player.fire_weapons
      @human_player.fire_weapons
    end

    assert_equal 2, @human_player.number_of_shots

  end
end
