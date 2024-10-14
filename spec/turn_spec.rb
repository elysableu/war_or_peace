require 'rspec'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'

RSpec.describe Turn do
  # Create variables that will be used multiple times
  # before(:each) do
  #   @card1 = Card.new(:diamond, 'Queen', 12)
  #   @card2 = Card.new(:spade, '3', 3)
  #   @card3 = Card.new(:heart, 'Ace', 14)
  #   @card4 = Card.new(:diamond, 'Jack', 11)
  #   @card5 = Card.new(:club, '7', 7)
  #   @card6 = Card.new(:heart, 'King', 13)
  #   @card7 = Card.new(:spade, '8', 8)
  #   @card8 = Card.new(:diamond, 'Queen', 12)
  #   @card_set1 = [@card1, @card2, @card3, @card4]
  #   @card_set2 = [@card5, @card6, @card7, @card8 ]
  #   @deck1 = Deck.new(@card_set1)
  #   @deck2 = Deck.new(@card_set2)
  #   @player1 = Player.new("Fred", @deck1)
  #   @player2 = Player.new("Gerald", @deck2)
  #   @turn = Turn.new(@player1, @player2)
  # end

  describe "initialize" do
    before(:each) do
      @card1 = Card.new(:diamond, 'Queen', 12)
      @card2 = Card.new(:spade, '3', 3)
      @card3 = Card.new(:heart, 'Ace', 14)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:club, '7', 7)
      @card6 = Card.new(:heart, 'King', 13)
      @card7 = Card.new(:spade, '8', 8)
      @card8 = Card.new(:diamond, 'Queen', 12)
      @card_set1 = [@card1, @card2, @card3, @card4]
      @card_set2 = [@card5, @card6, @card7, @card8 ]
      @deck1 = Deck.new(@card_set1)
      @deck2 = Deck.new(@card_set2)
      @player1 = Player.new("Fred", @deck1)
      @player2 = Player.new("Gerald", @deck2)
      @turn = Turn.new(@player1, @player2)
    end
    #Check that turn is a Turn object
    it "is a turn" do
      expect(@turn).to be_an_instance_of(Turn)
    end

    # Check that the player attributes are readable
    it "has readable attributes" do
      expect(@turn.player1).to eq(@player1)
      expect(@turn.player2).to eq(@player2)
      expect(@turn.spoils_of_war).to eq([])
    end
  end

  describe ":basic" do
    before(:each) do
      @card1 = Card.new(:diamond, 'Queen', 12)
      @card2 = Card.new(:spade, '3', 3)
      @card3 = Card.new(:heart, 'Ace', 14)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:club, '7', 7)
      @card6 = Card.new(:heart, 'King', 13)
      @card7 = Card.new(:spade, '8', 8)
      @card8 = Card.new(:diamond, 'Queen', 12)
      @card_set1 = [@card1, @card2, @card3, @card4]
      @card_set2 = [@card5, @card6, @card7, @card8 ]
      @deck1 = Deck.new(@card_set1)
      @deck2 = Deck.new(@card_set2)
      @player1 = Player.new("Fred", @deck1)
      @player2 = Player.new("Gerald", @deck2)
      @turn = Turn.new(@player1, @player2)
    end
    # can be basic type
    it "can be basic type" do
      expect(@turn.type()).to eq("basic")
    end
    # winner is player1 by default
    it "can have a winner" do
      expect(@turn.winner).to eq(@player1)
    end

    # sends the top cards from each players deck to spoils_of_War
    it "pile_cards adds cards to spoils_of_war" do
      player1_top_card = @player1.deck.cards[0]
      player2_top_card = @player2.deck.cards[0]

      @turn.pile_cards

      expect(@turn.spoils_of_war[0]).to eq(player1_top_card)
      expect(@turn.spoils_of_war[1]).to eq(player2_top_card)
    end

    # Player's top card has changed/ been removed
    it "top card changes to next card" do
      expect(@turn.player1.deck.cards[0]).to eq(@player1.deck.cards[0])
      expect(@turn.player2.deck.cards[0]).to eq(@player2.deck.cards[0])
      
      player1_next_card = @player1.deck.cards[1]
      player2_next_card = @player2.deck.cards[1]

      @turn.pile_cards
      
      expect(@turn.player1.deck.cards[0]).to eq(player1_next_card)
      expect(@turn.player2.deck.cards[0]).to eq(player2_next_card)
    end

    #award_spoils to the turn winner
    it "spoils_of_war is added to winner's deck" do
      
      expect(@turn.winner.deck.cards[-1]).to eq(@turn.winner.deck.cards[-1])
      expect(@turn.winner.deck.cards[-2]).to eq(@turn.winner.deck.cards[-2])

      @turn.award_spoils(@turn.spoils_of_war[0])
      expect(@turn.winner.deck.cards[-1]).to eq(@turn.spoils_of_war[0])

      @turn.award_spoils(@turn.spoils_of_war[0])
      expect(@turn.winner.deck.cards[-1]).to eq(@turn.spoils_of_war[0])
    end
  end

  describe ":war" do

    # winner

    # pile_cards

    # award_spoils

  end

  describe ":mutually_assured_destruction" do 
  
    # winner

    # pile_cards

     # award_spoils

  end

end