module Display
    def display_game_start
        puts "Welcome to Hangman!"
    end
    def display_game_options
        puts <<~HEREDOC

        Select one of the options:
        1. NEW GAME
        2. LOAD GAME
        
        HEREDOC
    end
    def display_word(word)
        puts """
        Word:
        #{word}
        """
    end
    def display_word(guess)
        puts guess
    end
    def display_incorrect_guess
        puts "Incorrect guess!"
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
        |       / | \
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
        |       / | \
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
        |       / | \
        |         |
        |        / \  
        |       /   \
        |
        |
        HEREDOC

    @@gallows = [@@half_gallows, @@gallows, @@head, @@arm, @@arms, @@leg, @@full]
    def display_lives(lives)
        puts <<~HEREDOC
        You have #{lives} lives left.

        #{@@gallows[7-lives]}
        HEREDOC
    end

    def raise_game_option_error
        puts error_format("Please choose 1 or 2.")
    end

    def raise_guess_error
        puts error_format("Please enter a single letter or a word.")
    end


    private
    def error_format(msg)
        "\e[#{msg}\e[0m"
    end
end