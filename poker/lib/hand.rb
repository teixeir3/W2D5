class Hand

  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def pair?
    @cards.each_index do |i|
      (i + 1...@cards.count).each do |j|
        return true if @cards[i].value == @cards[j].value
      end
    end

    false
  end

  def find_pair
    @cards.each_index do |i|
      (i + 1...@cards.count).each do |j|
        return [i,j] if @cards[i].value == @cards[j].value
      end
    end

    nil
  end

  def three_of_a_kind?
    @cards.each_index do |i|
      (i + 1...@cards.count).each do |j|
        (j + 1...@cards.count).each do |x|
          return true if @cards[i].value == @cards[j].value &&
          @cards[j].value == @cards[x].value
        end
      end
    end

    false
  end

  def four_of_a_kind?
    @cards.each_index do |i|
      (i + 1...@cards.count).each do |j|
        (j + 1...@cards.count).each do |x|
          (x + 1...@cards.count).each do |y|
            return true if @cards[i].value == @cards[j].value &&
            @cards[j].value == @cards[x].value &&
            @cards[x].value == @cards[y].value
          end
        end
      end
    end

    false
  end

  def two_pair?
    duped_arr = Array.new

    @cards.each do |card|
      temp_suit = card.suit
      temp_value = card.value
      duped_arr << Card.new(temp_suit, temp_value)
    end

    new_hand = Hand.new(duped_arr)

    pair_one = new_hand.find_pair.reverse

    pair_one.each do |i|
      new_hand.cards.delete_at(i)
    end

    has_pair = (new_hand.pair?) ? true : false
  end

  def has_straight?
    values = @cards.map(&:get_poker_value).sort
    (values[0]..values[-1]).to_a == values ? true : false
  end

  def has_flush?
    suits = @cards.map(&:suit)
    test_suit = suits[0]
    suits.all? { |suit| suit == test_suit }
  end

  def has_full_house?
    two_pair? ? three_of_a_kind? : false
  end
end