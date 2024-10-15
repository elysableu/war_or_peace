require_relative './lib/game.rb'
require_relative './lib/card_generator.rb'
require 'pry'

# Create two decks from hardcoded card sets
# card1 = Card.new(:diamond, 'Queen', 12)
# card2 = Card.new(:spade, '3', 3)
# card3 = Card.new(:heart, 'Ace', 14)
# card4 = Card.new(:diamond, 'Jack', 11)
# card5 = Card.new(:club, '6', 6)
# card6 = Card.new(:diamond, '2', 2)
# card7 = Card.new(:spade, '2', 2)
# card8 = Card.new(:heart, '4', 4)
# card9 = Card.new(:club, 'Jack', 11)
# card10 = Card.new(:spade, 'Ace', 14)
# card11 = Card.new(:club, 'Queen', 12)
# card12 = Card.new(:heart, 'King', 13)
# card13 = Card.new(:spade, '8', 8)
# card14 = Card.new(:diamond, 'Queen', 12)
# card15 = Card.new(:club, '7', 7)
# card16 = Card.new(:spade, '9', 9)
# card17 = Card.new(:heart, '2', 2)
# card18 = Card.new(:club, 'King', 13)
# card19 = Card.new(:spade, '4', 4)
# card20 = Card.new(:diamond, '7', 7)
# card_set1 = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10]
# card_set2 = [card11, card12, card13, card14, card15, card16, card17, card18, card19, card20]

# Create two random card sets from CardGenerator
deck_file_path = './cards.txt'
full_deck = CardGenerator.new(deck_file_path).generate_deck
card_set1 = full_deck[0..25]
card_set2 = full_deck[26..52]

# Welcome message
puts 'Welcome to War! (or Peace) This game will be played with 52 cards.'
puts "Who's playing today?"
puts "Player1: "
input_player1 = gets.chomp # Get player1's name from terminal
puts "Player2: "
input_player2 = gets.chomp # Get player2's name from terminal
puts "Looks like our players today are #{input_player1} and #{input_player2}."

# Create new game
game = Game.new(input_player1, input_player2, card_set1, card_set2)

puts "Type 'GO' to start the game!"
input = gets.chomp
puts "---------------------------------------------------------------"

# Start game when user inputs "GO"
if input == "GO"
  game.start()
else
  puts "Boo, guess you're not interested :-/"
end