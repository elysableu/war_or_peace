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
    # Basic type if rank_of_cards are not the same
    if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0) || 
      @player1.deck.rank_of_cards_at(0) < @player2.deck.rank_of_card_at(0)
      return "basic"
    # War type if rank_of_cards are the same
    # Mutually_assured_destruction if when both players
    # rank_of_card_at(0) and rank_of_card_at(2)
    end
  end
  
  def winner
    if type == "basic"
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        return @player1
      else
        return @player2
      end
    end
  end

  # Add cards to the spoils_of_war
  def pile_cards
    spoils_of_war << player1.deck.remove_card
    spoils_of_war << player2.deck.remove_card
  end

  def award_spoils(card)
    winner.deck.add_card(card)
  end
end

