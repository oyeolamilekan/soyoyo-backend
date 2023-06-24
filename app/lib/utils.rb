module Utils
    def self.generate_random_string
        # define the characters to use in the random string
        characters = ('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a

        # generate a random string with a length of 10 characters
        random_string = Array.new(20) { characters.sample }.join

        return random_string
    end
end