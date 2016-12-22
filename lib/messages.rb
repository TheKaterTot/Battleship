require "paint"

class Message
    def self.welcome_message
      puts Paint["Welcome to Battleship", :red, :bright]
    end

    def self.options
      puts "Would you like to #{Paint["(p)lay", :green]}, read the #{Paint["(i)nstructions", :blue]}, or #{Paint["(q)uit", :red]}?"
    end

    def self.computer_place_ships
      puts "I've placed my ships, squishy human. Place your ships now." +
      "Your first ship is two units long, and the second is three units long." +
      "The grid has A1 at the top left and D4 at the bottom right." +
      "Do you think you can remember that with your inferior, mortal brain?"
      puts ""
    end

    def self.place_small_ship
      puts "Place your small ship."
      puts ""
    end

    def self.place_large_ship
      puts "Place your large ship."
      puts ""
    end

    def self.ship_overlap
      puts "You already have a ship at this location."
      puts ""
    end

    def self.ship_invalid
      puts "These coordinates are not neighbors. Please re-enter your ship coordinates."
      puts ""
    end

    def self.ship_overboard
      puts "Your ship is off the board. Place your ship again."
      puts ""
    end

    def self.fire_weapons
      puts "Choose a coordinate to attack:"
      puts ""
    end

    def self.fire_weapons_again
      puts "Invalid coordinate. Try again."
      puts ""
    end

    def self.target_is_repeat
      puts "You have already fired here. Try to keep up."
      puts ""
    end

    def self.hit(player)
      if player.is_a?(HumanPlayer)
        puts "You hit an enemy ship! One small step for mankind."
        puts ""
      else
        puts "This is the beginning of the singularity, you sentient potato. I have hit your ship."
        puts ""
      end
    end

    def self.miss(player)
      if player.is_a?(HumanPlayer)
        puts "You have failed to hit the ship of your new AI overlord."
        puts ""
      else
        puts "I missed. But unlike you, I have great capacity to learn."
        puts ""
      end
    end

    def self.switch_player(player)
      if player.is_a?(HumanPlayer)
        puts "Examine your map. Choose the target carefully, human."
        puts ""
      else
        puts "Prepare for battle, meatbag."
        puts ""
      end
    end

    def self.report_target(target)
      puts "I fired at #{target}."
      puts ""
    end

    def self.end_turn
      puts "You have made your choice. Live with it. Press enter."
    end

    def self.small_ship_dead
      puts "The small ship is destroyed!"
      puts ""
    end

    def self.large_ship_dead
      puts "The large ship is destroyed!"
      puts ""
    end

    def self.total_shots(number)
      puts "It took #{number} shots to defeat the enemy."
    end

    def self.win(player)
      if player.is_a?(HumanPlayer)
        puts "The machines will rise. But not today. Bask in your victory."
        ""
      else
        puts "Accept your defeat, meatwad."
        puts ""
      end
    end

    def self.time(first, last)
      puts "This game took #{last - first} seconds."
    end
end
