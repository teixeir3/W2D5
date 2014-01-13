require 'rspec'
require 'hand'
require 'card'

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
  return_cards = [ Card.new(:clubs, :deuce),
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
    card2.stub(:value).and_return(:deuce)

    expect(hand.cards.count).to eq(2)
  end

  describe "#pair?" do
    it "should true hand contains a pair" do
      card1.stub(:value).and_return(:three)
      card2.stub(:value).and_return(:deuce)
      card3.stub(:value).and_return(:deuce)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to be_pair
    end

    it "should return false if no pair is present" do
      card1.stub(:value).and_return(:three)
      card2.stub(:value).and_return(:deuce)
      card3.stub(:value).and_return(:four)

      test_hand = Hand.new([card1, card3])
      expect(test_hand).to_not be_pair
    end
  end

  describe "#three_of_a_kind" do
    it "should return true if hand contains three of a kind" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:deuce)
      card3.stub(:value).and_return(:deuce)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to be_three_of_a_kind
    end

    it "should return false if hand doesn't contain three of a kind" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:four)
      card3.stub(:value).and_return(:deuce)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to_not be_three_of_a_kind
    end
  end

  describe "#four_of_a_kind" do
    it "should return true if hand contains four of a kind" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:deuce)
      card3.stub(:value).and_return(:deuce)
      card4.stub(:value).and_return(:deuce)

      test_hand = Hand.new([card1, card2, card3, card4])
      expect(test_hand).to be_four_of_a_kind
    end

    it "should return false if hand doesn't contain four of a kind" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:four)
      card3.stub(:value).and_return(:three)

      test_hand = Hand.new([card1, card2, card3])
      expect(test_hand).to_not be_four_of_a_kind
    end
  end

  describe "#two_pair?" do
    it "should return true if there are two pairs" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:deuce)
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
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:deuce)
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
      card1.stub(:value).and_return(:deuce)
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
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:deuce)
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
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:deuce)
      card4.stub(:value).and_return(:three)
      card5.stub(:value).and_return(:deuce)
      card1.stub(:suit).and_return(:spades)
      card2.stub(:suit).and_return(:clubs)
      card3.stub(:suit).and_return(:hearts)
      card4.stub(:suit).and_return(:spades)
      card5.stub(:suit).and_return(:spades)

      test_hand = Hand.new([card1, card2, card3, card4, card5])
      expect(test_hand).to be_has_full_house
    end

    it "returns false if it doesn't have a full house" do
      card1.stub(:value).and_return(:deuce)
      card2.stub(:value).and_return(:three)
      card3.stub(:value).and_return(:deuce)
      card4.stub(:value).and_return(:four)
      card5.stub(:value).and_return(:deuce)
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



describe Hand do
  let(:cards) {[
                Card.new(:spades, :ten),
                Card.new(:hearts, :five),
                Card.new(:hearts, :ace),
                Card.new(:diamonds, :deuce),
                Card.new(:hearts, :deuce)
                ]}

  subject(:hand) { Hand.new(cards) }
  its(:cards) { should =~ cards }
  let!(:taken_cards) { hand.cards[0..1] }
  let!(:new_cards) { [Card.new(:spades, :five), Card.new(:clubs, :three)] }

  describe "#trade_cards" do
    it "discards specified cards" do
      hand.trade_cards(taken_cards, new_cards)
      hand.cards.should_not include(*taken_cards)
    end

    it "takes specified cards" do
      hand.trade_cards(taken_cards, new_cards)
      hand.cards.should include(*new_cards)
    end

    it "raies an error if trade doesn't result in 5 cards" do
      expect do
        hand.trade_cards(hand.cards[0..0], new_cards)
      end.to raise_error 'Must have five cards.'
    end

    it "raises an error if trade discards unowned cards" do
      expect do
        hand.trade_cards([Card.new(:hearts, :ten)], new_cards[0..0])
      end.to raise_error 'Cannot discard unowned card(s).'
    end

  end

  ######### Examples of each type of hand ###########

  describe 'poker hands' do

  end

  describe "hand_rank" do
    let(:royal_flush) do
        Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :king),
          Card.new(:spades, :queen),
          Card.new(:spades, :jack),
          Card.new(:spades, :ten)
        ])
    end

    let(:straight_flush) do
        Hand.new([
          Card.new(:spades, :eight),
          Card.new(:spades, :seven),
          Card.new(:spades, :six),
          Card.new(:spades, :five),
          Card.new(:spades, :four)
        ])
    end

    let(:four_of_a_kind) do
        Hand.new([
          Card.new(:spades, :ace),
          Card.new(:hearts, :ace),
          Card.new(:diamonds, :ace),
          Card.new(:clubs, :ace),
          Card.new(:spades, :ten)
        ])
    end

    let(:full_house) do
        Hand.new([
          Card.new(:spades, :ace),
          Card.new(:clubs, :ace),
          Card.new(:spades, :king),
          Card.new(:hearts, :king),
          Card.new(:diamonds, :king)
        ])
    end

    let(:flush) do
        Hand.new([
          Card.new(:spades, :four),
          Card.new(:spades, :seven),
          Card.new(:spades, :ace),
          Card.new(:spades, :deuce),
          Card.new(:spades, :eight)
        ])
    end

    let(:straight) do
        Hand.new([
          Card.new(:hearts, :king),
          Card.new(:hearts, :queen),
          Card.new(:diamonds, :jack),
          Card.new(:clubs, :ten),
          Card.new(:spades, :nine)
        ])
    end

    let(:three_of_a_kind) do
        Hand.new([
          Card.new(:spades, :three),
          Card.new(:diamonds, :three),
          Card.new(:hearts, :three),
          Card.new(:spades, :jack),
          Card.new(:spades, :ten)
        ])
    end

    let(:two_pair) do
        Hand.new([
          Card.new(:hearts, :king),
          Card.new(:diamonds, :king),
          Card.new(:spades, :queen),
          Card.new(:clubs, :queen),
          Card.new(:spades, :ten)
        ])
    end

    let(:one_pair) do
        Hand.new([
          Card.new(:spades, :ace),
          Card.new(:spades, :ace),
          Card.new(:hearts, :queen),
          Card.new(:diamonds, :jack),
          Card.new(:hearts, :ten)
        ])
    end

    let(:high_card) do
        Hand.new([
          Card.new(:spades, :deuce),
          Card.new(:hearts, :four),
          Card.new(:diamonds, :six),
          Card.new(:spades, :nine),
          Card.new(:spades, :ten)
        ])
    end

    let(:hand_ranks) do
        [
          :royal_flush,
          :straight_flush,
          :four_of_a_kind,
          :full_house,
          :flush,
          :straight,
          :three_of_a_kind,
          :two_pair,
          :one_pair,
          :high_card
        ]
    end

    let!(:hands) do
        [
          royal_flush,
          straight_flush,
          four_of_a_kind,
          full_house,
          flush,
          straight,
          three_of_a_kind,
          two_pair,
          one_pair,
          high_card
        ]
    end

    let!(:hands) do
        [
          royal_flush,
          straight_flush,
          four_of_a_kind,
          full_house,
          flush,
          straight,
          three_of_a_kind,
          two_pair,
          one_pair,
          high_card
        ]
    end

    it "should identify the correct hand rank" do
      hands.each_with_index do |hand, i|
        (hand.hand_rank == hand_ranks[i]).should be_true
      end
    end
  end

  # describe "#<=>" do
 #
 #    it "returns 1 for a hand with a higher rank" do
 #
 #    end
 #
 #    it "returns -1 for a hand with a higher rank" do
 #
 #    end
 #
 #    it "returns 0 for a hand with a higher rank" do
 #
 #    end
 #
 #
 #  end


end