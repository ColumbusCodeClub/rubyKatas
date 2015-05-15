require 'rspec'
require 'rspec/autorun'
require './pacman'

describe 'be pacman' do

  before() do
    @world = Array.new(21) { Array.new(21) }
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

    @world[@world.size-1][10].should == @pacman
  end

  it 'pacman should wrap from the top of the grid to the bottom' do
    @pacman.turn(:north)

    11.times do
      @pacman.tick
    end

    @world[10][0].should == @pacman
  end

  it 'pacman should wrap from the bottom of the grid to the top' do
    @pacman.turn(:south)

    11.times do
      @pacman.tick
    end

    @world[10][@world.size-1].should == @pacman
  end

  it 'pacman should wrap from the right of the grid to the left' do
    @pacman.turn(:east)

    11.times do
      @pacman.tick
    end

    @world[0][10].should == @pacman
  end

  it 'pacman should stop when it hits a wall' do
    @world[11][10] = :wall
    @pacman.tick
    @world[10][10].should == @pacman
  end

  it 'should not be able to turn north toward an adjacent wall' do
    @world[10][11] = :wall
    @pacman.turn(:north)
    @pacman.direction.should == :east
  end

  it 'should not be able to turn south toward an adjacent wall' do
    @world[10][9] = :wall
    @pacman.turn(:south)
    @pacman.direction.should == :east
  end

  it 'should not be able to turn west toward an adjacent wall' do
    @world[9][10] = :wall
    @pacman.turn(:west)
    @pacman.direction.should == :east
  end

  it 'should not be able to turn east toward an adjacent wall' do
    @pacman.turn(:west)
    @world[11][10] = :wall
    @pacman.turn(:east)
    @pacman.direction.should == :west
  end

  it 'should not be able to turn in to another wall' do
    @pacman.tick
    @pacman.tick
    @world[12][11] = :wall
    @pacman.turn(:north)
    @pacman.direction.should == :east
  end

  it 'should eat dot' do
    @world[11][10] = :dot
    @pacman.tick
    @pacman.tick
    @world[11][10].should_not == :dot
  end

  it 'should increment dots eaten' do
    @world[11][10] = :dot
    @pacman.tick
    @pacman.dots_eaten.should == 1
  end

  it 'should eat two dots' do
    @world[11][10] = :dot
    @world[12][10] = :dot
    @pacman.tick
    @pacman.tick
    @pacman.dots_eaten.should == 2
  end

  it 'should not eat a dot if no dot is encountered' do
    @pacman.tick
    @pacman.dots_eaten.should == 0
  end

end

