class Ship
  def initialize(hit_points)
    @destroyed = false
    @hit_points = hit_points
  end

  def destroyed?
    @destroyed
  end

  def hit
    @hit_points - 1
  end



end
