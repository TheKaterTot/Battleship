require "./lib/player"

class ComputerPlayer < Player

  # def generate_coordinate
  #   coordinates = []
  #   2.times do
  #     first = ("A".."D").to_a.sample
  #     second = ("1".."4").to_a.sample
  #     coordinates.push(first + second)
  #   end
  #   coordinates
  # end

  def place_ships
    small_first, small_second = ["A1", "A2"]
    place_small_ship(small_first, small_second)
    large_first, large_second = ["B1", "B3"]
    place_large_ship(large_first, large_second)
    Message.computer_place_ships
  end

  def fire_weapons
    "A2"
  end
end
