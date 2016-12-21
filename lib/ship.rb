class Ship
  def initialize(hit_points)
    @destroyed = false
    @hit_points = hit_points
  end

  def destroyed?
    @destroyed
  end

  def destroyed
    if @hit_points == 0
      @destroyed = true
    end
  end

  def hit
    @hit_points -= 1
  end



end
