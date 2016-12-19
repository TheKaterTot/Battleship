require "./lib/computer_player"
require "./lib/human_player"

class Battleship
  attr_accessor :player_1, :player_2, :current_player

  def initialize
    @player_1 = HumanPlayer.new
    @player_2 = ComputerPlayer.new
    @current_player = player_1
  end

  def start
    puts "Welcome to Battleship."
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    response = gets.chomp
    play if response == "p" || response == "play"
    instructions if response == "i" or response == "instructions"
    quit if response == "q" || response == "quit"
  end

  def switch_player
    if @current_player == player_1
      @current_player = player_2
    else
      @current_player
    end
  end

  def play
    @player_1.place_ships
    @player_2.place_ships
    until @current_player.ship_1.is_destroyed? && @current_player.ship_2.is_destroyed?
      @current_player.fire_weapons
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
