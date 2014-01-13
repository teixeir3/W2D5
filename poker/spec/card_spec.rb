require 'rspec'
require_relative 'card.rb'

describe Card do
  subject(:card) { Card.new(:spades, :four) }
  its(:value) { should == :four }
end