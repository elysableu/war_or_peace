require_relative 'Card'
require_relative 'Deck'
require_relative 'Player'
require_relative 'Turn'

class Game

  # Initialize players and decks
  def initialize(player1_name, player2_name, card_set1, card_set2)
    @player1_name = player1_name
    @player2_name = player2_name
    @card_set1 = card_set1
    @card_set2 = card_set2
    @turn_count = 1
  end

  def start
    deck1 = Deck.new(@card_set1)
    deck2 = Deck.new(@card_set2)
    player1 = Player.new(@player1_name, deck1)
    player2 = Player.new(@player2_name, deck2)
    turn = Turn.new(player1, player2)

    until turn.player1.deck.count == 52 || turn.player2.deck.count == 5 || @turn_count == 1000
      play(turn)
    end
  end

  def play(turn)
      # Return Turn (turn count)
      print "Turn #{@turn_count}: "
      @turn_count += 1
      # Play turn
      # if turn type not basic return type
      if turn.type != :basic
        if turn.type == :war
          winner = turn.winner.dup
          type_of_turn = turn.type.to_s
          turn.pile_cards
          num_to_be_awarded = turn.spoils_of_war.length
          print "#{type_of_turn} - #{winner.name} won #{num_to_be_awarded} cards \n"
          turn.award_spoils(winner)
        else
          winner = turn.winner.dup
          type_of_turn = turn.type.to_s
          turn.pile_cards
          num_to_be_removed = 6
          print "*#{type_of_turn}* #{num_to_be_removed} cards removed from play \n"
          turn.award_spoils(winner)
        end
      else 
        winner = turn.winner.dup
        turn.pile_cards
        num_to_be_awarded = turn.spoils_of_war.length
        print "#{winner.name} won #{num_to_be_awarded} cards \n"
        turn.award_spoils(winner)
      end
      # Return winner and cards won
  end
end