require 'pry-byebug'
# binding.pry

require_relative "./game.rb"

def play
    hangman = Game.new
    hangman.play
end

play