class Pacman
  attr_accessor :location, :direction

  def initialize(world)
    @world = world
    @location = [(world.size/2).to_i, (world.size/2).to_i]
    @world[location[0]][location[1]] = self
    @direction = :east
  end

  END_OF_BOARD = 10

  MOVES = {
      :east => lambda { |this| this.tick_east },
      :north => lambda { |this| this.tick_north },
      :west => lambda { |this| this.tick_west },
      :south => lambda { |this| this.tick_south }
  }

  def tick
    MOVES[@direction].call(self)
  end

  def move(east_west, north_south)
    @world[location[0]][location[1]] = nil
    location[0] += east_west
    location[1] += north_south
    if (location[0] < 0)
      location[0] = @world.size-1
    end
    if (location[1] < 0)
      location[1] = @world.size-1
    end
    if (location[1] == @world.size)
      location[1] = 0
    end
    if (location[0] == @world.size)
      location[0] = 0
    end
    @world[location[0]][location[1]] = self
  end

  def tick_south
      move(0, -1)
  end

  def tick_west
      move(-1, 0)
  end

  def tick_east
      move(1, 0)
  end

  def tick_north
      move(0, 1)
  end

  def turn(direction)
    @direction = direction
  end

end