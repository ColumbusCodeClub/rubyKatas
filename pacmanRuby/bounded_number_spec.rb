require 'rspec'
require './bounded_number'

describe 'The bounded number' do

  before() do
    @number = BoundedNumber.new(0, -20, 20)
  end

  it 'should have the value it receives' do
    @number.value.should == 0
  end

  it 'should increment the value' do
    @number.increment()
    @number.value.should == 1
  end
end