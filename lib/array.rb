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

  def my_transpose
    arr = Array.new(self.count) {[]}

    self.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        arr[j][i] = cell
      end
    end

    arr
  end

  def stock_picker
    arr = []
    best_profit = 0

    self.each_index do |i|
      (i+1..self.count - 1).each do |j|
        profit = self[j] - self[i]
        if profit > best_profit
          arr = [i, j]
          best_profit = profit
        end
      end
    end

    arr
  end
end