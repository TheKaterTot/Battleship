require "./lib/computer_player"
require "./lib/human_player"

class Battleship
  attr_reader :player_1, :player_2, :current_player

  def initialize
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
    @current_player = player_1
  end

  def other_player
    if current_player == player_1
      player_2
    else
      player_1
    end
  end

  def switch_player
    if @current_player == player_1
      @current_player = player_2
    else
      @current_player = player_1
    end
  end

  def start
    Message.welcome_message
    Message.options
    response = gets.chomp
    play if response == "p" || response == "play"
    instructions if response == "i" or response == "instructions"
    quit if response == "q" || response == "quit"
  end

  def play
    player_1.place_ships
    player_2.place_ships
    until current_player.ship_1.destroyed? && current_player.ship_2.destroyed?
      Message.switch_player(current_player)
      target = current_player.fire_weapons
      if other_player.fired_at(target)
        Message.hit
      else
        Message.miss
      end
      switch_player
    end
  end

  def instructions
    instructions = File.read("./lib/battleship_instructions.txt")
    puts instructions
  end

  def quit
    exit 0
  end

end
