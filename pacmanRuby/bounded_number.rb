class BoundedNumber
  attr_reader :value

  def initialize(initial_value, lower_bound, upper_bound)
    @value = initial_value
  end

  def increment
    @value += 1
  end
end