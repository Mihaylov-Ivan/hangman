require_relative './string_formatting'

module Display
    def display_game_start
        puts "Welcome to Hangman!".bold
        puts "To save and exit your game, enter '*save*' at any point during the game."
        puts "To exit, enter '*exit*'."
    end
    def display_game_options
        puts <<~HEREDOC

        Select one of the options:
        1. NEW GAME
        2. LOAD GAME
        3. Exit
        
        HEREDOC
    end
    def display_word(guess)
        puts guess
    end
    def display_incorrect_guess
        puts "Incorrect guess!".yellow
    end
    def display_you_win
        puts "Good job! You guessed the word and escaped the gallows.".green
    end
    def display_you_lose
        puts "You've been hanged!".red
    end
    def display_game_save_exists
        puts "A saved game with the same name already exists. Do you want to overwrite it?".gray
    end
    def display_no_saved_games
        puts "You don't have any saved games.".gray
    end
    def display_saved_games(games)
        puts "Select a saved game, or type *exit* to return to main menu:".bold
        puts games
    end
    def display_guessed_letters(letters_guessed)
        print "Letters guessed: "
        letters_guessed.each {|letter| print letter + " "}
        puts
    end

    @@half_gallows = <<~HEREDOC
        |/
        |
        |
        |
        |
        |
        |
        |
        |
        HEREDOC
    @@gallows = <<~HEREDOC
        ---------------
        |/
        |
        |
        |
        |
        |
        |
        |
        |
        HEREDOC
    @@head = <<~HEREDOC
        ---------------
        |/        |
        |         |
        |         @
        |
        |
        |
        |
        |
        |
        HEREDOC
    @@arm = <<~HEREDOC
        ---------------
        |/        |
        |         |
        |         @
        |       / |
        |         |
        |
        |
        |
        |
        HEREDOC
    @@arms = <<~HEREDOC
        ---------------
        |/        |
        |         |
        |         @
        |       / | \\
        |         |
        |
        |
        |
        |
        HEREDOC
    @@leg = <<~HEREDOC
        ---------------
        |/        |
        |         |
        |         @
        |       / | \\
        |         |
        |        /  
        |       /  
        |
        |
        HEREDOC
    @@full = <<~HEREDOC
        ---------------
        |/        |
        |         |
        |         @
        |       / | \\
        |         |
        |        / \\  
        |       /   \\
        |
        |
        HEREDOC

    @@gallows = [@@half_gallows, @@gallows, @@head, @@arm, @@arms, @@leg, @@full]
    def display_lives(lives)
        puts <<~HEREDOC
        You have #{lives} lives left.

        #{@@gallows[6-lives]}
        HEREDOC
    end

    def raise_game_option_error
        puts "Please choose 1, 2 or 3.".red
    end
    def raise_guess_error
        puts "Please enter a single letter or a word.".red
    end
    def raise_game_save_error
        puts "Please enter a valid folder name.".red
    end
    def raise_yes_or_no_input_error
        puts "Please enter 'yes' or 'no'.".red
    end
    def raise_saved_game_does_not_exist(game)
        puts "#{game} does not exist.".red
    end

    # def raise_game_option_error
    #     puts error_format("Please choose 1, 2 or 3.")
    # end
    # def raise_guess_error
    #     puts error_format("Please enter a single letter or a word.")
    # end
    # def raise_game_save_error
    #     puts error_format("Please enter a valid folder name.")
    # end
    # def raise_yes_or_no_input_error
    #     puts error_format("Please enter 'yes' or 'no'.")
    # end
    # def raise_saved_game_does_not_exist(game)
    #     puts error_format("#{game} does not exist.")
    # end

    # private
    # def error_format(msg)
    #     "\e[31;1m#{msg}\e[0m"
    # end
end