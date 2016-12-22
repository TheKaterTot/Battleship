require "./test/test_helper"
require "./lib/battleship"
require "stringio"

class BattleshipTest < Minitest::Test
  def setup
    @game = Battleship.new
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


  def test_start_calls_play
    with_stdio do |input, ouput|
      input.puts "p"

      @game.expects :play
      @game.start
    end
  end

  def test_start_calls_play
    with_stdio do |input, output|
      input.puts "play"

      @game.expects :play
      @game.start
    end
  end

  def test_start_calls_instructions
    with_stdio do |input, output|
      input.puts "i"

      @game.expects :instructions
      @game.start
    end
  end

  def test_start_calls_instructions
    with_stdio do |input, output|
      input.puts "instructions"

      @game.expects :instructions
      @game.start
    end
  end

  def test_start_calls_quit
    with_stdio do |input, output|
      input.puts "q"

      @game.expects :quit
      @game.start
    end
  end

  def test_start_calls_quit
    with_stdio do |input, output|
      input.puts "quit"

      @game.expects :quit
      @game.start
    end
  end

  def test_for_two_players
    assert_equal HumanPlayer, @game.player_2.class
    assert_equal ComputerPlayer, @game.player_1.class
  end

  def test_alternates_players
    @game.switch_player

    assert_equal @game.current_player, @game.player_2
  end

  def test_prints_instructions
    with_stdio do |input, output|
      @game.instructions

      assert_includes(output.gets, "Place your ships on the coordinates")
    end
  end
end
