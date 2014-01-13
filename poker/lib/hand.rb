
class Hand

  attr_reader :cards

  HAND_RANKS = [
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

  def initialize(cards)
    @cards = cards
  end

  def trade_cards(taken_cards, new_cards)

    raise "Must have five cards." unless taken_cards.count == new_cards.count

    taken_cards.each do |card|
      raise "Cannot discard unowned card(s)." unless @cards.include?(card)
    end


    @cards -= taken_cards


    new_cards.each do |card|
      @cards << card
    end

    nil
  end

  def hand_rank
    rank = ""
    if has_royal_flush?
      rank = HAND_RANKS[0]
    elsif has_straight_flush?
      rank = HAND_RANKS[1]
    elsif four_of_a_kind?
      rank = HAND_RANKS[2]
    elsif has_full_house?
      rank = HAND_RANKS[3]
    elsif has_flush?
      rank = HAND_RANKS[4]
    elsif has_straight?
      rank = HAND_RANKS[5]
    elsif three_of_a_kind?
      rank = HAND_RANKS[6]
    elsif two_pair?
      rank = HAND_RANKS[7]
    elsif pair?
      rank = HAND_RANKS[8]
    else
      rank = HAND_RANKS[9]
    end

    rank
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
  # UNTESTED
  def find_triple
    @cards.each_index do |i|
      (i + 1...@cards.count).each do |j|
        (j + 1...@cards.count).each do |x|
          return [i,j,x] if @cards[i].value == @cards[j].value && @cards[j].value == @cards[x].value
        end
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
    has_pair = false
    if pair?
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

    has_pair
  end

  def has_straight?
    (sort_hand[0]..sort_hand[-1]).to_a == sort_hand ? true : false
  end

  def has_flush?
    suits = @cards.map(&:suit)
    test_suit = suits[0]
    suits.all? { |suit| suit == test_suit }
  end

  def has_full_house?
    # pair? ? three_of_a_kind? : false
    has_full_house = false
    if three_of_a_kind?

      duped_arr = Array.new

      @cards.each do |card|
        temp_suit = card.suit
        temp_value = card.value
        duped_arr << Card.new(temp_suit, temp_value)
      end

      new_hand = Hand.new(duped_arr)

      triple_pos = new_hand.find_triple.reverse

      triple_pos.each do |i|
        new_hand.cards.delete_at(i)
      end

      has_full_house = new_hand.pair?
    end

    has_full_house
  end

  def has_straight_flush?
    has_straight? ? has_flush? : false
  end

  def has_royal_flush?
    (10..14).to_a == sort_hand ? has_flush? : false
  end

  def get_high_card
    sort_hand.last
  end

  def sort_hand
    poker_values = @cards.map(&:get_poker_value)
    poker_values.sort
  end
end