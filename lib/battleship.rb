require "./lib/computer_player"
require "./lib/human_player"

class Battleship
  attr_reader :player_1, :player_2, :current_player

  def initialize
    @player_1 = ComputerPlayer.new
    @player_2 = HumanPlayer.new
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
    until current_player.destroyed?
      Message.switch_player(current_player)
      current_player.draw_board
      target = current_player.fire_weapons
      if other_player.fired_at(target)
        Message.hit(current_player)
        current_player.track_hit(target)
      else
        Message.miss(current_player)
        current_player.track_miss(target)
      end
      current_player.draw_board
      current_player.end_turn
      switch_player
    end
    Message.win(other_player)
  end

  def instructions
    instructions = File.read("./lib/battleship_instructions.txt")
    puts instructions
  end

  def quit
    exit 0
  end

end
