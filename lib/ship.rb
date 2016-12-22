class Ship
  def initialize(hit_points)
    @hit_points = hit_points
  end

  def destroyed?
    @hit_points == 0
  end

  def hit
    @hit_points -= 1
  end
end
