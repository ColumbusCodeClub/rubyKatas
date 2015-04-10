require 'rspec'

describe 'be pacman' do

  before() do
    @pacman = Pacman.new([[1,0]])
  end

  it 'pacman should be on a grid' do
    @pacman.location.should == [0, 0]
  end

  it 'pacman should start facing east' do
    @pacman.direction.should == :east
  end

  it 'pacman should move on a tick' do
    @pacman.tick
    @pacman.location.should == [1, 0]
  end

  it 'pacman should move on each tick' do
    @pacman.tick
    @pacman.tick
    @pacman.location.should == [2, 0]
  end

  it 'pacman should allow the user to rotate direction' do
    @pacman.turn(:north)
    @pacman.direction.should == :north
  end

  it 'pacman should move one space north on tick' do
    @pacman.turn(:north)
    @pacman.tick
    @pacman.location.should == [0,1]
  end

  it 'pacman should move back when direction is west on tick' do
    @pacman.turn(:west)
    @pacman.tick
    @pacman.location.should == [-1,0]
  end

  it 'pacman should move down when direction is south on tick' do
    @pacman.turn(:south)
    @pacman.tick
    @pacman.location.should == [0,-1]
  end

  it 'pacman should wrap from one end of the grid to another' do
    @pacman.turn(:west)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [Pacman::END_OF_BOARD,0]
  end

  it 'pacman should wrap from the top of the grid to the bottom' do
    @pacman.turn(:north)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [0,-Pacman::END_OF_BOARD]
  end

  it 'pacman should wrap from the bottom of the grid to the top' do
    @pacman.turn(:south)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [0,Pacman::END_OF_BOARD]
  end

  it 'pacman should wrap from the right of the grid to the left' do
    @pacman.turn(:east)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [-Pacman::END_OF_BOARD, 0]
  end

  it 'pacman should stop when it hits a wall' do

    @pacman.tick

    @pacman.location.should == [0, 0]
  end

end

class Pacman
  attr_accessor :location, :direction

  def initialize(wall)
    @walls = wall
    @location = [0, 0]
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
    location[0] += east_west
    location[1] += north_south
  end

  def tick_south
    if (@location[1] == -END_OF_BOARD)
      @location[1] = END_OF_BOARD
    else
      move(0, -1)
    end
  end

  def tick_west
    if (@location[0] == -END_OF_BOARD)
      @location[0] = END_OF_BOARD
    else
      move(-1, 0)
    end
  end

  def tick_east
    if (@location[0] == END_OF_BOARD)
      @location[0] = -END_OF_BOARD
    else
      move(1, 0)
    end
  end

  def tick_north
    if (@location[1] == END_OF_BOARD)
      @location[1] = -END_OF_BOARD
    else
      move(0, 1)
    end
  end

  def turn(direction)
    @direction = direction
  end

end