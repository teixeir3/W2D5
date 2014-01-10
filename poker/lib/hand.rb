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
end