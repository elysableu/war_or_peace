require 'rspec'
require './lib/player'
require './lib/deck'
require './lib/card'

RSpec.describe Player do
  # Create variables that will be used multiple times
  before(:each) do
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:diamond, 'Jack', 11)
    @card5 = Card.new(:club, '7', 7)
    @cards = [@card1, @card2, @card3]
    @deck = Deck.new(@cards)
    @player = Player.new("Fred", @deck)
  end
  
  # Check player has a readable name attribute
  it "has a name" do
    expect(@player.name).to eq("Fred")
  end
  # Check player has a readable deck attribute
  it "has a deck" do
    expect(@player.deck).to eq(@deck)
  end

  # Check that a card can be removed from a player's deck
  it "can remove card from deck" do
    expect(@player.deck.count).to eq(3)
    expect(@player.deck.cards[0]).to eq(@card1)
    
    @player.deck.remove_card
    expect(@player.deck.count).to eq(2)
    expect(@player.deck.cards[0]).to eq(@card2)
  end

  # Check player has the ability to lose
  it "can lose the game" do
    expect(@player.has_lost?).to be false

    @player.deck.remove_card
    @player.deck.remove_card
    @player.deck.remove_card
    expect(@player.has_lost?).to be true
  end
  
end