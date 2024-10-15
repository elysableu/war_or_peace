require_relative 'Card'

class CardGenerator 

  def initialize(deck_file_path)
    @deck_file_path = deck_file_path
  end

# Create 52 cards (read in from text file)
  def generate_deck
    full_deck = File.readlines(@deck_file_path).map do |card|
      value, suit, rank = card.chomp.split(', ')
      Card.new(suit, value.to_s, rank.to_i)
    end
    full_deck.shuffle
  end
end