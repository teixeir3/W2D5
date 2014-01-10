require 'debugger'

class Tower
  # attr_accessor just for testing
  attr_accessor :arr

  def initialize
    @arr = [[3,2,1],[],[]]
  end

  def render
    @arr
  end

  def move(from,destination)
    from, destination = (from - 1), (destination - 1)

    return false if @arr.count < from
    return false if @arr[from].empty?

    from_last, dest_last = @arr[from].last, @arr[destination].last

    if dest_last.nil? || dest_last > from_last
      @arr[destination] << @arr[from].pop
    elsif !@arr[destination].nil? || dest_last < from_last
      return false
    end

    won? ? true : true
  end

  def won?
    return true if @arr[2] == [3, 2, 1]

    false
  end

end