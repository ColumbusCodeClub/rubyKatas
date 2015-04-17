require 'rspec'
require './pacman'

describe 'be pacman' do

  before() do
    @world = Array.new(21) {Array.new(21 ) }
    @pacman = Pacman.new(@world)
  end

  it 'pacman should be on a grid' do
    @world[10][10].should == @pacman
  end

  it 'pacman should start facing east' do
    @pacman.direction.should == :east
  end

  it 'pacman should move on a tick' do
    @pacman.tick
    @world[11][10].should == @pacman
  end

  it 'pacman should move on each tick' do
    @pacman.tick
    @pacman.tick
    @world[12][10].should == @pacman
  end

  it 'pacman should allow the user to rotate direction' do
    @pacman.turn(:north)
    @pacman.direction.should == :north
  end

  it 'pacman should move one space north on tick' do
    @pacman.turn(:north)
    @pacman.tick
    @world[10][11].should == @pacman
  end

  it 'pacman should move back when direction is west on tick' do
    @pacman.turn(:west)
    @pacman.tick
    @world[9][10].should == @pacman
  end

  it 'pacman should move down when direction is south on tick' do
    @pacman.turn(:south)
    @pacman.tick
    @world[10][9].should == @pacman
  end

  it 'pacman should wrap from one end of the grid to another' do
    @pacman.turn(:west)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [@world.size-1,10]
    @world[@world.size-1][10].should == @pacman
  end

  it 'pacman should wrap from the top of the grid to the bottom' do
    @pacman.turn(:north)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [10,0]
    @world[10][0].should == @pacman
  end

  it 'pacman should wrap from the bottom of the grid to the top' do
    @pacman.turn(:south)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [10,@world.size-1]
    @world[10][@world.size-1].should == @pacman
  end

  it 'pacman should wrap from the right of the grid to the left' do
    @pacman.turn(:east)

    11.times do
      @pacman.tick
    end

    @pacman.location.should == [0,10]
    @world[0][10].should == @pacman
  end

  it 'pacman should stop when it hits a wall' do

    pending
    @pacman.tick

    @pacman.location.should == [0, 0]
  end

end

