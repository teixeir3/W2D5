require 'rspec'
require 'array'

describe Array do
  describe "#my_uniq" do
    it 'removes duplicate elements' do
      expect([1,2,1,3,3].my_uniq).to eq([1,2,3])
    end
  end

  describe "#two_sum" do
    it 'returns the index of each element that sums to zero' do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
  end

  describe "#my_transpose" do
    it "transposes an array of arrays" do
      rows = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ]

      cols = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
        ]
      expect(rows.my_transpose).to eq(cols)
    end
  end

  describe "#stock_picker" do
    it "picks the most profitable days" do
      stocks = [3, 0, 2, 9, 3, 4]
      expect(stocks.stock_picker).to eq([1,3])
    end
  end
end