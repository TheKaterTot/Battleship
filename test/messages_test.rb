require "./test/test_helper"
require "./lib/messages"
require "stringio"

class MessageTest < Minitest::Test

  def setup
    @player = HumanPlayer.new
    @computer = ComputerPlayer.new
  end

  def test_options
    with_stdio do |input, output|
      Message.options
      assert_includes output.gets, "Would you like"
    end
  end

  def test_computer_can_place_ships
    with_stdio do |input, output|
      Message.computer_place_ships
      assert_includes output.gets, "I've placed my ships"
    end
  end

  def test_place_small_ship
    with_stdio do |input, output|
      Message.place_small_ship
      assert_includes output.gets, "Place your"
    end
  end

  def test_place_large_ship
    with_stdio do |input, output|
      Message.place_large_ship
      assert_includes output.gets, "Place your large"
    end
  end

  def test_ship_overlap
    with_stdio do |input, output|
      Message.ship_overlap
      assert_includes output.gets, "You already"
    end
  end

  def test_ship_invalid
    with_stdio do |input, output|
      Message.ship_invalid
      assert_includes output.gets, "neighbors"
    end
  end

  def test_ship_overboard
    with_stdio do |input, output|
      Message.ship_overboard
      assert_includes output.gets, "Your ship is off"
    end
  end

  def test_fire_weapons
    with_stdio do |input, output|
      Message.fire_weapons
      assert_includes output.gets, "attack"
    end
  end

  def test_fire_again
    with_stdio do |input, output|
      Message.fire_weapons_again
      assert_includes output.gets, "Try again"
    end
  end

  def test_repeat_target
    with_stdio do |input, output|
      Message.target_is_repeat
      assert_includes output.gets, "Try to keep up"
    end
  end

  def test_hit
    with_stdio do |input, output|
      Message.hit(@player)
      assert_includes output.gets, "mankind"
      output.gets
      Message.hit(@computer)
      assert_includes output.gets, "singularity"
    end
  end

  def test_miss
    with_stdio do |input, output|
      Message.miss(@player)
      assert_includes output.gets, "failed"
      output.gets
      Message.miss(@computer)
      assert_includes output.gets, "capacity"
    end
  end

  def test_target
    with_stdio do |input, output|
      Message.report_target("A2")
      assert_includes output.gets, "A2"
    end
  end

  def test_total_shots
    with_stdio do |input, output|
      Message.total_shots(3)
      assert_includes output.gets, "3"
    end
  end

  def test_win
    with_stdio do |input, output|
      Message.win(@player)
      assert_includes output.gets, "victory"
      Message.win(@computer)
      assert_includes output.gets, "defeat"
    end
  end
end
