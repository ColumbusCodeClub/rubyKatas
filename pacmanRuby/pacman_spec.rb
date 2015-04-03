require 'rspec'

describe 'be pacman' do

  before() do
    @pacman = Pacman.new()
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

    @pacman.location.should == [10,0]
  end

end

class Pacman
  attr_accessor :location, :direction

  def initialize()
    @location = [0, 0]
    @direction = :east
  end

  def tick
    case @direction
    when :east
      @location[0] += 1
    when :north
      @location[1] += 1
    when :west
      @location[0] -= 1
    when :south
      @location[1] -= 1
    end
  end

  def turn(direction)
    @direction = direction
  end

end