require 'rspec'
require 'hand'

#     Straight flush
#     Royal flush
# (x) Four of a kind
#     Full house
#     Flush
#     Straight
# (x) Three of a kind
# (x) Two pair
# (x) One pair
#     High card

describe Hand do
  return_cards = [ Card.new(:clubs, :two),
                 Card.new(:spades, :three)]

  let(:card1) { double("card1") }
  let(:card2) { double("card2") }
  let(:card3) { double("card3") }
  let(:card4) { double("card4") }
  subject(:hand) { Hand.new([card1, card2]) }

  it "should initialize with 2 cards" do
    card1.stub(:suit).and_return(:spades)
    card1.stub(:value).and_return(:three)
    card2.stub(:suit).and_return(:clubs)
    card2.stub(:value).and_return(:two)

    expect(hand.cards.count).to eq(2)
  end

  describe "#pair?" do
    it "should true hand contains a pair" do
      card1.stub(:value).and_return(:three)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:two)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to be_pair
    end

    it "should return false if no pair is present" do
      card1.stub(:value).and_return(:three)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:four)

      test_hand = Hand.new([card1, card3])
      expect(test_hand).to_not be_pair
    end
  end

  describe "#three_of_a_kind" do
    it "should return true if hand contains three of a kind" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:two)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to be_three_of_a_kind
    end

    it "should return false if hand doesn't contain three of a kind" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:four)
      card3.stub(:value).and_return(:two)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to_not be_three_of_a_kind
    end
  end

  describe "#four_of_a_kind" do
    it "should return true if hand contains four of a kind" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:two)
      card4.stub(:value).and_return(:two)

      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to be_four_of_a_kind
    end

    it "should return false if hand doesn't contain four of a kind" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:four)
      card3.stub(:value).and_return(:three)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to_not be_four_of_a_kind
    end
  end

  describe "#two_pair?" do
    it "should return true if there are two pairs" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:three)
      card4.stub(:value).and_return(:three)

      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to be_two_pair
    end

    it "should return false if there are two pairs" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:four)
      card4.stub(:value).and_return(:three)

      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to_not be_two_pair
    end
  end
end