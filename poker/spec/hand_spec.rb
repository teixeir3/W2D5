require 'rspec'
require 'hand'

# (x) Straight flush
# (x) Royal flush
# (x) Four of a kind
# (x) Full house
# (x) Flush
# (x) Straight
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
  let(:card5) { double("card5") }
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
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to be_two_pair
    end

    it "should return false if there are two pairs" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:two)
      card3.stub(:value).and_return(:four)
      card4.stub(:value).and_return(:three)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)


      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to_not be_two_pair
    end
  end

  describe "#has_straight" do
    it "should return true if given a straight" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:four)
      card4.stub(:value).and_return(:five)
      card5.stub(:value).and_return(:six)
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(3)
      card3.stub(:get_poker_value).and_return(4)
      card4.stub(:get_poker_value).and_return(5)
      card5.stub(:get_poker_value).and_return(6)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_straight
    end

    it "should return false if not given a straight" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:two)
      card4.stub(:value).and_return(:five)
      card5.stub(:value).and_return(:six)
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(3)
      card3.stub(:get_poker_value).and_return(2)
      card4.stub(:get_poker_value).and_return(5)
      card5.stub(:get_poker_value).and_return(6)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_straight
    end
  end

  describe "#has_flush?" do
    it "returns true if has flush" do
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_flush
    end

    it "returns false if no flush" do
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:hearts)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_flush
    end
  end

  describe "#has_full_house?" do

    it "returns true if it has a full house" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:two)
      card4.stub(:value).and_return(:three)
      card5.stub(:value).and_return(:two)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:clubs)
      card3.stub(:suit).and_return(:hearts)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_full_house
    end

    it "returns false if it has a full house" do
      card1.stub(:value).and_return(:two)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:two)
      card4.stub(:value).and_return(:four)
      card5.stub(:value).and_return(:two)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:clubs)
      card3.stub(:suit).and_return(:hearts)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_full_house
    end
  end

  describe "#has_straight_flush?" do

    it "returns true if it has a straight flush" do
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(3)
      card3.stub(:get_poker_value).and_return(4)
      card4.stub(:get_poker_value).and_return(5)
      card5.stub(:get_poker_value).and_return(6)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_straight_flush
    end

    it "returns false if it has flush but no straight" do
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(3)
      card3.stub(:get_poker_value).and_return(2)
      card4.stub(:get_poker_value).and_return(4)
      card5.stub(:get_poker_value).and_return(2)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_straight_flush
    end

    it "returns false if it has straight but no flush" do
      card1.stub(:suit).and_return(:clubs)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)
      card1.stub(:get_poker_value).and_return(4)
      card2.stub(:get_poker_value).and_return(3)
      card3.stub(:get_poker_value).and_return(2)
      card4.stub(:get_poker_value).and_return(5)
      card5.stub(:get_poker_value).and_return(6)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_straight_flush
    end
  end

  describe "#has_royal_flush?" do

    it "returns true if it has a royal flush" do
      card1.stub(:get_poker_value).and_return(10)
      card2.stub(:get_poker_value).and_return(11)
      card3.stub(:get_poker_value).and_return(12)
      card4.stub(:get_poker_value).and_return(13)
      card5.stub(:get_poker_value).and_return(14)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_royal_flush
    end

    it "returns false if it has a flush, but not royal :(" do
      card1.stub(:get_poker_value).and_return(10)
      card2.stub(:get_poker_value).and_return(9)
      card3.stub(:get_poker_value).and_return(11)
      card4.stub(:get_poker_value).and_return(12)
      card5.stub(:get_poker_value).and_return(13)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:spades)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_royal_flush
    end

    it "returns false if it is a royal straight but not flush" do
      card1.stub(:get_poker_value).and_return(10)
      card2.stub(:get_poker_value).and_return(11)
      card3.stub(:get_poker_value).and_return(12)
      card4.stub(:get_poker_value).and_return(13)
      card5.stub(:get_poker_value).and_return(14)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:hearts)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:clubs)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_royal_flush
    end

    it "returns false if it's a shitty hand" do
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(5)
      card3.stub(:get_poker_value).and_return(6)
      card4.stub(:get_poker_value).and_return(8)
      card5.stub(:get_poker_value).and_return(3)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:hearts)
      card3.stub(:suit).and_return(:spades)
      card4.stub(:suit).and_return(:clubs)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to_not be_has_royal_flush
    end
  end

  describe "#get_high_card" do
    it "returns the highest card in your hand" do
      card1.stub(:get_poker_value).and_return(2)
      card2.stub(:get_poker_value).and_return(5)
      card3.stub(:get_poker_value).and_return(6)
      card4.stub(:get_poker_value).and_return(8)
      card5.stub(:get_poker_value).and_return(3)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand.get_high_card).to eq(8)
    end
  end
end