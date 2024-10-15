require 'rspec'
require 'pry'
require './lib/deck'
require './lib/card'

RSpec.describe Deck do
  # Create variables that will be used repeatedly
  before(:each) do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:club, '7', 7)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
  end

  # Check if deck is initializing
  it "exists" do
    expect(@deck).to be_an_instance_of(Deck)
  end

  # Check if deck contains array of cards
  it "has readable attributes" do
    expect(@deck.cards).to eq(@cards)
  end

  # Check if array of cards contains card objects
  it "single card is readable and is Card object" do
    expect(@deck.cards[0]).to be_an_instance_of(Card)
    expect(@deck.cards[1]).to eq(@card2)
  end

  # Can access card rank through rate_of_card_at
  it "can access card rank" do
    expect(@deck.rank_of_card_at(0)).to eq(@card1.rank)
    expect(@deck.rank_of_card_at(1)).to eq(@card2.rank)
  end

  # Checks if a new card can be added to the bottom of the deck
  it "cards can be added to the bottom of deck" do
    expect(@deck.cards[-1]).to eq(@card3)
    
    @deck.add_card(@card4)
    expect(@deck.cards[-1]).to eq(@card4)
    
    @deck.add_card(@card5)
    expect(@deck.cards[-1]).to eq(@card5)
  end

  # Check that a card can be removed form the top of the deck
  it "removes cards from the top of the deck" do
    expect(@deck.cards[0]).to eq(@card1)

    @deck.remove_card()
    expect(@deck.cards[0]).to eq(@card2)

    @deck.remove_card()
    expect(@deck.cards[0]).to eq(@card3)
  end

  # Check Return the ranking of a card at a specific index
  it "checks the ranking of a card at an specific index" do
    expect(@deck.rank_of_card_at(2)).to eq(14)
  end

  # Return an array of the cards in deck that are ranking 11 or greater
  it "will return an array of high ranking cards, rank 11 or above" do
    expect(@deck.high_ranking_cards).to eq([@card1, @card3])
  end

  # Return the percentage of high ranking cards in the deck
  it "can return percentage of high ranking cards" do
    expected = ((2.0 / 3.0) * 100.0).round(2)
    expect(@deck.percent_high_ranking).to eq(expected)
  end
end
