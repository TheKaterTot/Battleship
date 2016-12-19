require "./lib/player"

class HumanPlayer < Player

  def place_ships
    puts "Place your small ship"
    coordinates = gets.chomp
    coordinates = coordinates.split(" ")
    x = coordinates[0]
    y = coordinates[1]
    place_small_ship(x, y)
    puts "Place your large ship"
    coordinates = gets.chomp
    coordinates = coordinates.split(" ")
    x = coordinates[0]
    y = coordinates[1]
    place_large_ship(x, y)
    ships_placed
  end

  def fire(coordinate)
    map_coordinate = coordinate.chars
    if map_coordinate[0][map_coordinate[1]] == "*"
      puts "Hit!"
      @shots_fired[map_coordinate[0]][map_coordinate[1]] == "H"
    else
      puts "Miss!"
      @shots_fired[map_coordinate[0]][map_coordinate[1]] == "M"

  end
end
