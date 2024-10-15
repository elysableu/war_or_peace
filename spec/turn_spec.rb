require 'rspec'
require 'pry'
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
      expect(@turn.type).to eq(:basic)
    end
    # winner is player1 by default
    it "can have a winner" do
      winner = @turn.winner
      expect(winner).to eq(@player1)
    end

    # sends the top cards from each players deck to spoils_of_War
    it "pile_cards adds cards to spoils_of_war" do
      player1_top_card = @player1.deck.cards[0]
      player2_top_card = @player2.deck.cards[0]

      @turn.pile_cards

      expect(@turn.spoils_of_war).to eq([player1_top_card, player2_top_card])
    end

    ## Unnecessary test
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
    it "all of spoils_of_war is added to winner's deck" do 
      winner = @turn.winner
      expect(winner.deck.cards[-2..-1]).to eq([@card3, @card4])
      @turn.pile_cards

      to_be_awarded = @turn.spoils_of_war
      @turn.award_spoils(winner)

      expect(winner.deck.cards[-2..-1]).to eq(to_be_awarded)
    end

    it "empties spoils_of_war after cards are awarded" do
      winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(winner)

      expect(@turn.spoils_of_war).to eq([])
    end

    # Player's decks have been updated
    it "updates player's decks after spoils awarded" do
      winner = @turn.winner
      loser = (winner == @turn.player1) ? @turn.player2 : @turn.player1
      
      # Save duplicate of decks before turn
      winner_deck = winner.deck.cards.dup
      loser_deck = loser.deck.cards.dup
      
      @turn.pile_cards

      # Simulate pile_cards and determine expected outcomes
      winner_deck.shift()
      loser_deck.shift()
      expected_winner_outcome = winner_deck + @turn.spoils_of_war
      expected_loser_outcome = loser_deck

      @turn.award_spoils(winner)

      expect(winner.deck.cards).to eq(expected_winner_outcome)
      expect(loser.deck.cards).to eq(expected_loser_outcome)
    end
  end

  describe ":war" do
    before(:each) do
      @card1 = Card.new(:diamond, 'Queen', 12)
      @card2 = Card.new(:spade, '3', 3)
      @card3 = Card.new(:heart, 'Ace', 14)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:club, '6', 6)
      @card6 = Card.new(:diamond, '2', 2)
      @card7 = Card.new(:spade, '2', 2)
      @card8 = Card.new(:heart, '4', 4)
      @card9 = Card.new(:club, 'Jack', 11)
      @card10 = Card.new(:spade, 'Ace', 14)
      @card11 = Card.new(:club, 'Queen', 12)
      @card12 = Card.new(:heart, 'King', 13)
      @card13 = Card.new(:spade, '8', 8)
      @card14 = Card.new(:diamond, 'Queen', 12)
      @card15 = Card.new(:club, '7', 7)
      @card16 = Card.new(:spade, '9', 9)
      @card17 = Card.new(:heart, '2', 2)
      @card18 = Card.new(:club, 'King', 13)
      @card19 = Card.new(:spade, '4', 4)
      @card20 = Card.new(:diamond, '7', 7)
      @card_set1 = [@card1, @card2, @card3, @card4, @card5, @card6, @card7, @card8, @card9, @card10]
      @card_set2 = [@card11, @card12, @card13, @card14, @card15, @card16, @card17, @card18, @card19, @card20]
      @deck1 = Deck.new(@card_set1)
      @deck2 = Deck.new(@card_set2)
      @player1 = Player.new("Fred", @deck1)
      @player2 = Player.new("Gerald", @deck2)
      @turn = Turn.new(@player1, @player2)
    end
    
    it "can be war type" do
      expect(@turn.type).to eq(:war)
    end

    # winner
    it "can have a winner" do
      expect(@turn.winner).to eq(@player1)
    end

    # pile_cards
    it "war turn cards (6 cards) are piled into spoils_of_war" do
      @turn.pile_cards
      
      expect(@turn.spoils_of_war).to eq([@card1, @card11, @card2, @card12, @card3, @card13])
    end

    # Players top card is changed to the 4th card in the deck
    it "changes top card of player's deck" do
      expect(@turn.player1.deck.cards[0]).to eq(@player1.deck.cards[0])
      expect(@turn.player2.deck.cards[0]).to eq(@player2.deck.cards[0])
      
      player1_next_card = @player1.deck.cards[3]
      player2_next_card = @player2.deck.cards[3]

      @turn.pile_cards
      
      expect(@turn.player1.deck.cards[0]).to eq(player1_next_card)
      expect(@turn.player2.deck.cards[0]).to eq(player2_next_card)
    end

    # award_spoils
    it "spoils_of_war cards (6 cards) are added to winner's deck" do
      winner = @turn.winner
      expect(winner.deck.cards[-6..-1]).to eq(@player1.deck.cards[-6..-1])

      @turn.pile_cards
      
      to_be_awarded = @turn.spoils_of_war
      @turn.award_spoils(winner)

      expect(winner.deck.cards[-6..-1]).to eq(to_be_awarded)
    end

    ## Unnecessary test
    # Each player's deck has increased in size (winner) or decreased in size (loser)
    it "effects the size of both player's decks after spoils are awarded" do
      winner_expected = (@player1.deck.cards.length - 3) + 6
      loser_expected = @player2.deck.cards.length - 3
      winner = @turn.winner
      loser = winner == @turn.player1 ? @turn.player2 : @turn.player1

      @turn.pile_cards
      @turn.award_spoils(winner)

      expect(winner.deck.cards.length).to eq(winner_expected)
      expect(loser.deck.cards.length).to eq(loser_expected)
    end

    # spoils_of_war empties after spoils are awarded
    it "empties spoils of war after cards are awarded" do
      winner = @turn.winner
      @turn.pile_cards
      @turn.award_spoils(winner)

      expect(@turn.spoils_of_war).to eq([])
    end

     # Player's decks have been updated
     it "updates player's decks after spoils awarded" do
      winner = @turn.winner
      loser = (winner == @turn.player1) ? @turn.player2 : @turn.player1
      
      # Save duplicate of decks before turn
      winner_deck = winner.deck.cards.dup
      loser_deck = loser.deck.cards.dup
      
      @turn.pile_cards

      # Simulate pile_cards and determine expected outcomes
      winner_deck.slice!(0, 3)
      loser_deck.slice!(0, 3)
      expected_winner_outcome = winner_deck + @turn.spoils_of_war
      expected_loser_outcome = loser_deck

      @turn.award_spoils(winner)

      expect(winner.deck.cards).to eq(expected_winner_outcome)
      expect(loser.deck.cards).to eq(expected_loser_outcome)
    end
  end

  describe ":mutually_assured_destruction" do 
    before(:each) do
      @card1 = Card.new(:diamond, 'Queen', 12)
      @card2 = Card.new(:spade, '3', 3)
      @card3 = Card.new(:heart, '8', 8)
      @card4 = Card.new(:diamond, 'Jack', 11)
      @card5 = Card.new(:club, '6', 6)
      @card6 = Card.new(:diamond, '2', 2)
      @card7 = Card.new(:spade, '2', 2)
      @card8 = Card.new(:heart, '4', 4)
      @card9 = Card.new(:club, 'Jack', 11)
      @card10 = Card.new(:spade, 'Ace', 14)
      @card11 = Card.new(:club, 'Queen', 12)
      @card12 = Card.new(:heart, 'King', 13)
      @card13 = Card.new(:spade, '8', 8)
      @card14 = Card.new(:diamond, 'Queen', 12)
      @card15 = Card.new(:club, '7', 7)
      @card16 = Card.new(:spade, '9', 9)
      @card17 = Card.new(:heart, '2', 2)
      @card18 = Card.new(:club, 'King', 13)
      @card19 = Card.new(:spade, '4', 4)
      @card20 = Card.new(:diamond, '7', 7)
      @card_set1 = [@card1, @card2, @card3, @card4, @card5, @card6, @card7, @card8, @card9, @card10]
      @card_set2 = [@card11, @card12, @card13, @card14, @card15, @card16, @card17, @card18, @card19, @card20]
      @deck1 = Deck.new(@card_set1)
      @deck2 = Deck.new(@card_set2)
      @player1 = Player.new("Fred", @deck1)
      @player2 = Player.new("Gerald", @deck2)
      @turn = Turn.new(@player1, @player2)
    end

    # can be type :mutually_assured_destruction
    it "can be mutually_assured_destruction type" do
      expect(@turn.type).to eq(:mutually_assured_destruction)
    end

    # No winner!
    it "can have no winner" do
      expect(@turn.winner).to eq("No Winner!")
    end

    # pile_cards
    it "pile_cards are removed from game play" do
      player1_expected_outcome = @turn.player1.deck.cards.slice(3..9)
      player2_expected_outccome = @turn.player2.deck.cards.slice(3..9)
    
      @turn.pile_cards()

      expect(@turn.player1.deck.cards).to eq(player1_expected_outcome)
      expect(@turn.player2.deck.cards).to eq(player2_expected_outccome)
    end

    # Spoils of war return an empty array
    it "has an empty spoils_of_war" do
      @turn.pile_cards()

      expect(@turn.spoils_of_war).to eq([])
    end

  end

end