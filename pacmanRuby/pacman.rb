class Pacman
  attr_accessor :direction
  attr_reader :dots_eaten

  def initialize(world)
    @world = world
    @location = start_location
    @world[x_axis][y_axis] = self
    @direction = :east
    @dots_eaten = 0
  end

  def tick
    move(@direction)
  end

  def turn(direction)
    return if wall_at_direction(direction)
    @direction = direction
  end

  private

  def move(direction)
    original_location = []

    set_original_location(original_location)
    initiate_move(DIRECTION_VECTORS[direction][0], DIRECTION_VECTORS[direction][1])
    handle_wrapping
    handle_dots
    handle_walls(original_location)
  end

  DIRECTION_VECTORS = {
      :east => [1, 0],
      :north => [0, 1],
      :west => [ -1, 0],
      :south => [0, -1]
  }

  def handle_dots
    if @world[@location[0]][@location[1]] == :dot
      @dots_eaten+=1
    end
  end

  def initiate_move(east_west, north_south)
    @location[0] += east_west
    @location[1] += north_south
  end

  def handle_wrapping
    wrap_to_right if (passed_left_boundary?)
    wrap_to_top if (passed_bottom_boundary?)
    wrap_to_bottom if (passed_top_boundary?)
    wrap_to_left if (passed_right_boundary?)
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

  def wall_at_direction(direction)
    x = @location[0] + DIRECTION_VECTORS[direction][0]
    y = @location[1] + DIRECTION_VECTORS[direction][1]

    return @world[x][y] == :wall
  end

  def start_location
    [center(@world), center(@world)]
  end

  def center(world)
    (world.size/2)
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