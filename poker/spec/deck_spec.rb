require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe "::all_cards" do
    it "should initialize with 52 different cards" do
      expect(deck.count).to eq(52)
    end
  end

  describe "#take" do
    it "should take cards from the top of the deck" do
      expect(deck.take(2).first).to be_an_instance_of(Card)
      expect(deck.take(2).count).to eq(2)
    end
  end

  describe "#return" do
    it "return an array of cards to the bottom of the deck" do
      return_cards = [ Card.new(:clubs, :two),
                     Card.new(:spades, :three)]
      num_cards = deck.count

      expect(deck.return(return_cards)).to eq(nil)
      expect(deck.count).to eq(54)
      expect(deck.cards.last.suit).to eq(:spades)
      expect(deck.cards.last.value).to eq(:three)
    end
  end
end