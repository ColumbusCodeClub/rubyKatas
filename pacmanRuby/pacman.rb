class Pacman
  attr_accessor :location, :direction

  def initialize(world)
    @world = world
    @location = [(world.size/2).to_i, (world.size/2).to_i]
    @world[location[0]][location[1]] = self
    @direction = :east
  end

  END_OF_BOARD = 10

  def tick
    MOVES[@direction].call(self)
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
    if @world[@location[0]][@location[1]+1] == :wall and direction == :north
    elsif @world[@location[0]][@location[1]-1] == :wall and direction == :south
    else
      @direction = direction
    end
  end

  private

  MOVES = {
      :east => lambda { |this| this.tick_east },
      :north => lambda { |this| this.tick_north },
      :west => lambda { |this| this.tick_west },
      :south => lambda { |this| this.tick_south }
  }

  def move(east_west, north_south)
    original_location = []
    original_location[0] = @location[0]
    original_location[1] = @location[1]

    @location[0] += east_west
    @location[1] += north_south
    if (@location[0] < 0)
      @location[0] = @world.size-1
    end
    if (@location[1] < 0)
      @location[1] = @world.size-1
    end
    if (@location[1] == @world.size)
      @location[1] = 0
    end
    if (@location[0] == @world.size)
      @location[0] = 0
    end

    check_for_walls(original_location)
  end

  def check_for_walls(original_location)
    if no_wall_exists
      continue_move(original_location)
    else
      return_to_original_location(original_location)
    end
  end

  def return_to_original_location(original_location)
    @location[0] = original_location[0]
    @location[1] = original_location[1]
  end

  def continue_move(original_location)
    clear_pacman_location(original_location)
    enter_new_pacman_location
  end

  def enter_new_pacman_location
    @world[@location[0]][@location[1]] = self
  end

  def clear_pacman_location(original_location)
    @world[original_location[0]][original_location[1]] = nil
  end

  def no_wall_exists
    @world[@location[0]][@location[1]] != :wall
  end


end