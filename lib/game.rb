require 'pry-byebug'
# binding.pry

require_relative "./word_generator.rb"
require_relative "./display.rb"

class Game
    include Display

    attr_accessor :word, :word_guess, :lives

    def initialize
        display_game_start
        display_game_options
        @word = ""
        @lives = 0
    end

    def play
        game_option = get_game_option
        game_option == "1" ? new_game : load_game
    end


    private

    def get_game_option
        game_option = gets.chomp.to_s
        until game_option == "1" || game_option == "2"
            raise_game_option_error
            display_game_options
            game_option = gets.chomp.to_s
        end
        game_option
    end
    def get_guess
        guess = gets.chomp.to_s
        until guess.match(/[a-zA-Z]+/) || guess.length < 1
            raise_guess_error
            guess = gets.chomp.to_s
        end
        guess
    end

    def new_game
        puts "Try to guess the word!"
        @word_guess = ""
        word_generator = WordGenerator.new
        @word = word_generator.word
        puts(word)
        (word.length).times {@word_guess += "_ "}
        play_game
    end
    def load_game
    end

    def play_game
        correct_guess = false
        lives = 7
        until lives <= 0 || correct_guess
            binding.pry
            display_lives(lives)
            display_word(word_guess)
            puts "Make your guess now:"
            guess = get_guess
            guess.length == 1 ? check_letter_guess(guess) : check_word_guess(guess)
        end
    end
    def check_letter_guess(guess)
        match = false
        word.split("").each_with_index do |char, i|
            next if char!=guess
            word_guess[i] == guess
            match = true
        end
        if !match then
            @lives -= 1
            display_incorrect_guess
        end
    end
end