class WordGenerator
    attr_reader :word

    def initialize
        generate_word
    end
    def generate_word
        @word = get_word
    end


    private

    def get_word
        File.readlines("../words.txt").map(&:chomp).sample
    end
end