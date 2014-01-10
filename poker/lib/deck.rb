class Deck

  attr_reader :cards

  def self.fill_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end

    deck.shuffle!
  end

  def initialize(cards = Deck.fill_deck)
    @cards =  cards
  end

  def count
    @cards.count
  end

  def take(amount)
    arr = []

    amount.times do
      arr << @cards.shift
    end

    arr
  end

  def return(cards)
    until cards.empty?
      @cards << cards.shift
    end

    nil
  end

end