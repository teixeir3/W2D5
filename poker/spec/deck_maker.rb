require '../lib/deck'
require '../lib/card'

deck_arr = Deck.new.cards
File.open("deck_helper.rb", "w") do |f|
  f.puts "def helper(matcher)"
  deck_arr.each do |card|
    abbrev = card.suit[0]
    f.puts "\treturn \"let(:#{card.get_poker_value}#{abbrev}) { double(\'#{card.get_poker_value}#{abbrev}\'), :value => #{card.value}, :get_poker_value => #{card.get_poker_value}, :suit => #{card.suit}}\" if matcher == \"#{card.get_poker_value}#{abbrev}\""
  end
  f.puts "end"
end