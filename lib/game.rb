require_relative "./word_generator.rb"
require_relative "./display.rb"
require_relative "./play_game.rb"

class Game
    include Display

    @@end_game = false

    def initialize
        display_game_start
    end

    def play
        until @@end_game
            display_game_options
            select_game_option
        end
    end

    # ==============PRIATE==============
    private

    def select_game_option
        game_option = get_game_option
        case game_option
        when "1"
            play_new_game
        when "2"
            play_saved_game
        else
            @@end_game = true
        end
    end
    def get_game_option
        option = gets.chomp.to_s
        until option == "1" || option == "2" || option == "3"
            raise_game_option_error
            display_game_options
            option = gets.chomp.to_s
        end
        option
    end

    def play_new_game
        lives = 6
        word_generator = WordGenerator.new
        word = word_generator.word
        word_guess = ""
        puts(word)
        (word.length).times {word_guess += "_ "}
        new_game = PlayGame.new(lives, word, word_guess, [])
        new_game.play_game
    end
    def play_saved_game
        if Dir.exist?('../saved_games') && Dir["../saved_games/*.yaml"].length > 0 then
            saved_games = Dir["../saved_games/*.yaml"]
            saved_games.map!{ |path| File.basename(path, ".yaml")}
            display_saved_games(saved_games)
        else
            display_no_saved_games
            return
        end
        game_to_load = get_saved_game(saved_games)
        return if game_to_load == "*exit*"
        data = YAML.load(File.read("../saved_games/#{game_to_load}.yaml"))
        loaded_game = PlayGame.new(data[0], data[1], data[2].join(" "), data[3])
        loaded_game.play_game
    end

    def get_saved_game(saved_games)
        game = gets.chomp.to_s
        until saved_games.include?(game) || game == "*exit*"
            raise_saved_game_does_not_exist(game)
            display_saved_games(saved_games)
            game = gets.chomp.to_s
        end
        game
    end
end