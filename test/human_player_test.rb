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

  def with_stdin
    stdin = $stdin
    $stdin, input = IO.pipe
    yield input
    input.close
    $stdin = stdin
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
end
