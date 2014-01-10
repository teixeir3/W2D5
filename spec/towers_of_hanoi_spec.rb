require 'rspec'
require 'towers_of_hanoi'

describe "towers_of_hanoi" do
  subject(:tower) { Tower.new }
  its(:arr) { should == [[3,2,1],[],[]] }

  describe "#render" do
    it "renders the game with an array of piles sizes" do
      expect(tower.render).to eq([[3,2,1],[],[]])
    end
  end

  describe "#move" do
    it "returns true when you move onto an empty space" do
      expect(tower.move(1,2)).to eq(true)
      expect(tower.arr[1]).to eq([1])
    end

    it "returns true when you move onto a larger space" do
      tower.move(1,2)
      expect(tower.arr[1]).to eq([1])
      expect(tower.move(2,1)).to eq(true)
    end

    it "returns false when you take from an empty pile" do
      expect(tower.move(2,1)).to eq(false)
    end

    it "returns false when you select a pile that's not in the range" do
      expect(tower.move(40,2)).to eq(false)
    end

    it "returns false when you move a larger piece onto a smaller piece" do
      tower.move(1,2)
      expect(tower.move(1,2)).to eq(false)
    end

    it "returns true when you make correct moves" do # TEST
      expect(tower.move(1, 3)).to eq(true)
      expect(tower.move(1, 2)).to eq(true)
      expect(tower.move(3, 2)).to eq(true)
      expect(tower.move(1, 3)).to eq(true)
      expect(tower.move(2, 1)).to eq(true)
      expect(tower.move(2, 3)).to eq(true)
      expect(tower.move(1, 3)).to eq(true)
    end
  end

   describe "#won?" do
    it "returns false at the beginning of the game" do
      expect(tower.won?).to eq(false)
    end

    it "returns true if all elements are moved to the right stack" do
      tower.arr[2] = [3,2,1]
      expect(tower.won?).to eq(true)
    end

  end
end