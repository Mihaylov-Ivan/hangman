require_relative "./game.rb"
require_relative './string_formatting'
require 'yaml'

class PlayGame
    include Display
    
    @@correct_guess = false

    attr_reader :word_guess, :word
    attr_accessor :lives, :letters_guessed

    def initialize(lives, word, word_guess, letters_guessed)
        @lives = lives
        @word = word
        @word_guess = word_guess
        @letters_guessed = letters_guessed
    end

    def play_game
        @@correct_guess = false
        break_word = ""
        until lives <= 0 || @@correct_guess
            display_lives(lives)
            display_word(word_guess.join(" "))
            puts "Make your guess now:"
            guess = get_guess
            case guess
            when "*save*"
                break_word = "save"
                break
            when "*exit*"
                break_word = "exit"
                break
            end
            guess.length == 1 ? check_letter_guess(guess) : check_word_guess(guess)
            display_guessed_letters(letters_guessed)
        end
        return if break_word == "exit"
        if break_word == "save"
            save_game
            return
        end
        @@correct_guess == true ? display_you_win : ( 
        display_lives(lives) 
        display_you_lose )
    end

    # ==============PRIATE==============
    private

    def get_guess
        guess = gets.chomp.to_s
        until guess.match(/[a-zA-Z]+/) || guess.length < 1
            raise_guess_error
            guess = gets.chomp.to_s
        end
        guess
    end

    def check_letter_guess(guess)
        match = false
        word.split("").each_with_index do |char, i|
            next if char!=guess
            @word_guess[i] = guess
            letters_guessed.push(guess.green) unless letters_guessed.include?(guess.green)
            match = true
            puts word.inspect
            if word == word_guess.join("") then @@correct_guess = true end
        end
        if !match then
            unless letters_guessed.include?(guess.red)
                @lives -= 1
                letters_guessed.push(guess.red)     
            end
            display_incorrect_guess
        end
    end
    def check_word_guess(guess)
        word == guess.downcase ? @@correct_guess = true : (
            @lives -= 1
            display_incorrect_guess
        )
    end

    def save_game
        Dir.mkdir('../saved_games') unless Dir.exist?('../saved_games')
        name = get_game_save_name
        filename = "../saved_games/#{name}.yaml"
        data = [lives, word, word_guess, letters_guessed]
        File.open(filename, "w") { |file| file.write(data.to_yaml) }
    end

    def get_game_save_name
        overwrite = "no"
        while overwrite == "no"
            puts "Name your game save:"
            name = gets.chomp.to_s
            until name.match('^[^\\\\\/\?\%\*\:\|\"<>]+$')
                raise_game_save_error
                name = gets.chomp.to_s
            end
            if File.exist?("../saved_games/#{name}.yaml") then
                display_game_save_exists
                overwrite = gets.chomp.to_s.downcase
                until overwrite == "yes" || overwrite == "no"
                    raise_yes_or_no_input_error
                    overwrite = gets.chomp.to_s.downcase
                end
            else
                break
            end
        end
        name
    end
end