class CardGenerator 

  def initialize(deck_file_path)
    @deck_file_path = deck_file_path
  end

# Create 52 cards (read in from text file)
  def generate_deck
    full_deck = File.readlines(@deck_file_path).map do |card|
      rank, suit, value = card.chomp.split(', ')
      [suit, rank, value.to_i]
    end
    return full_deck
  end
end

# full_deck = CardGenerator.generate_deck
# p full_deck