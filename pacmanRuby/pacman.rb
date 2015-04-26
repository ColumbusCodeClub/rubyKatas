class Pacman
  attr_accessor :location, :direction

  def initialize(world)
    @world = world
    @location = start_location
    @world[x_axis][y_axis] = self
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
    return if wall_at_direction(direction)
    @direction = direction
  end

  private

  def wall_at_direction(direction)
    return true if wall_north? and turning_north?(direction)
    return true if wall_south? and turning_south?(direction)
    return true if wall_west?  and turning_west?(direction)
    return true if wall_east?  and turning_east?(direction)
  end

  def turning_east?(direction)
    direction == :east
  end

  def wall_east?
    @world[x_axis+1][y_axis] == :wall
  end

  def turning_west?(direction)
    direction == :west
  end

  def wall_west?
    @world[x_axis-1][y_axis] == :wall
  end

  def wall_south?
    @world[x_axis][y_axis-1] == :wall
  end

  def turning_south?(direction)
    direction == :south
  end

  def turning_north?(direction)
    direction == :north
  end

  def wall_north?
    @world[x_axis][y_axis+1] == :wall
  end


  def start_location
    [center(@world), center(@world)]
  end

  def center(world)
    (world.size/2)
  end

  MOVES = {
      :east => lambda { |this| this.tick_east },
      :north => lambda { |this| this.tick_north },
      :west => lambda { |this| this.tick_west },
      :south => lambda { |this| this.tick_south }
  }

  def move(east_west, north_south)
    original_location = []

    set_original_location(original_location)
    initiate_move(east_west, north_south)
    handle_wrapping
    handle_walls(original_location)
  end

  def initiate_move(east_west, north_south)
    @location[0] += east_west
    @location[1] += north_south
  end

  def handle_wrapping
    if (passed_left_boundary?)
      wrap_to_right
    end
    if (passed_bottom_boundary?)
      wrap_to_top
    end
    if (passed_top_boundary?)
      wrap_to_bottom
    end
    if (passed_right_boundary?)
      wrap_to_left
    end
  end

  def passed_bottom_boundary?
    y_axis < 0
  end

  def passed_left_boundary?
    x_axis < 0
  end

  def passed_right_boundary?
    x_axis == @world.size
  end

  def passed_top_boundary?
    y_axis == @world.size
  end

  def wrap_to_top
    @location[1] = @world.size-1
  end

  def wrap_to_right
    @location[0] = @world.size-1
  end

  def wrap_to_left
    @location[0] = 0
  end

  def wrap_to_bottom
    @location[1] = 0
  end

  def set_original_location(original_location)
    original_location[0] = x_axis
    original_location[1] = y_axis
  end

  def handle_walls(original_location)
    if no_wall_exists
      continue_move(original_location)
    else
      return_to_original_location(original_location)
    end
  end

  def return_to_original_location(original_location)
    @location[0] = original_x(original_location)
    @location[1] = original_y(original_location)
  end

  def continue_move(original_location)
    clear_pacman_location(original_location)
    enter_new_pacman_location
  end

  def enter_new_pacman_location
    @world[x_axis][y_axis] = self
  end

  def clear_pacman_location(original_location)
    @world[original_x(original_location)][original_y(original_location)] = nil
  end

  def no_wall_exists
    @world[x_axis][y_axis] != :wall
  end

  def y_axis
    @location[1]
  end

  def x_axis
    @location[0]
  end

  def original_y(original_location)
    original_location[1]
  end

  def original_x(original_location)
    original_location[0]
  end

end