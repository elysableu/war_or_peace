require_relative 'player'
require_relative 'deck'
require_relative 'card'

class Turn
  attr_reader :player1, 
              :player2, 
              :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    # War type if rank_of_cards are the same
    if @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) 
      # Mutually_assured_destruction if when both players cards are the same at index 0 and 2
      if @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
        return :mutually_assured_destruction
      else
        return :war 
      end
    # Basic type if rank_of_cards are not the same
    elsif @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0) || 
      @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
      return :basic
    else
      return "Unknown type"
    end
  end
  
  def winner
    if type == :basic
      if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
        return @player1
      else
        return @player2
      end
    elsif type == :war
      if @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
        return @player1
      else 
        return @player2
      end
    elsif type == :mutually_assured_destruction
      return "No Winner!"
    else
      return "No winner can be determined at this time!"
    end
  end

  # Add cards to the spoils_of_war
  def pile_cards
    if type == :basic
      spoils_of_war << @player1.deck.cards[0]
      spoils_of_war << @player2.deck.cards[0]
      @player1.deck.remove_card
      @player2.deck.remove_card
    elsif type == :war
      3.times do
        spoils_of_war << @player1.deck.cards[0]
        spoils_of_war << @player2.deck.cards[0]
        @player1.deck.remove_card
        @player2.deck.remove_card
      end
    elsif type == :mutually_assured_destruction
      3.times do
        @player1.deck.remove_card
        @player2.deck.remove_card
      end
    end
  end


  def award_spoils(winner)
    if !@spoils_of_war.empty?
      @spoils_of_war.each do |card|
        winner.deck.add_card(card)
      end
    end
    @spoils_of_war = []
  end
end

