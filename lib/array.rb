class Array
  def my_uniq
    arr = []

    self.each do |element|
      arr << element unless arr.include?(element)
    end

    arr
  end

  def two_sum
    arr = []

    self.each_index do |i|
      (i+1..self.count - 1).each do |j|
        arr << [i, j] if self[i] + self[j] == 0
      end
    end

    arr
  end
end