require_relative 'Card'
require 'pry'

class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  # Returns the number of cards in deck
  def count
    @count = @cards.length
  end

  # takes index location of card to 
  # be used and will return rank of that card
  def rank_of_card_at(card_index)
    card = @cards[card_index]
    card.rank
    # binding.pry
  end

  # Return an array of cards in the deck that
  # have rank 11 or above
  def high_ranking_cards
    high_ranking = []
    @cards.each do |card|
      if card.rank >= 11
        high_ranking << card
      end
    end
    high_ranking
  end

  # Return percentage of cards that are high ranking
  def percent_high_ranking
    (high_ranking_cards.length.to_f / count * 100).round(2)
  end

  # Remove top card from the deck
  def remove_card
    @cards.shift()
    @cards
  end

  # Add one card to bottom of the deck 
  def add_card(card)
    @cards << card
  end
end
