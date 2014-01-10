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
end