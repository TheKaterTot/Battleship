class Message
    def self.welcome_message
      puts "Welcome to Battleship"
    end

    def self.options
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
    end

    def self.computer_place_ships
      puts "I've placed my ships. Place your ships now."
    end

    def self.ship_overlap
      puts "You already have a ship at."
    end

    def self.ship_invalid
      puts "These coordinates are not neighbors. Please re-enter your ship coordinates."
    end

    def self.fire_weapons
      puts "Choose a coordinate to attack"
    end

    def self.hit
      puts "You hit an enemy ship!"
    end

    def self.miss
      puts "You missed!"
    end

    def self.switch_player(player)
      if player.is_a?(HumanPlayer)
        puts "Your turn. Choose carefully."
      else
        puts "Wait while I destroy you, meatbag."
      end
    end
end
