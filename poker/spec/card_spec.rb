require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:spades, :four) }
  its(:value) { should == :four }
end