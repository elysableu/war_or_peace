require_relative 'deck'

class Player
  attr_reader :name, :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    if @deck.count == 0
      return true
    else
      return false
    end
  end
end