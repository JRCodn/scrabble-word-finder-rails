module PagesHelper
    SCORES = {  "a": 1, "c": 3, "b": 3, "e": 1, "d": 2, "g": 2,
                "f": 4, "i": 1, "h": 4, "k": 5, "j": 8, "m": 3,
                "l": 1, "o": 1, "n": 1, "q": 10, "p": 3, "s": 1,
                "r": 1, "u": 1, "t": 1, "w": 4, "v": 4, "y": 4,
                "x": 8, "z": 10 }


  # I don't play scrabble so this might not be 100% with how scrabble is played.
  # Returns top 10 words you could use in your rack.

  #Game logic

  # This method will check if the word can be made from the rack. Since this will
  # be the part of the code that will require the most processing. I've tried to
  # make a method that will fail and stop as soon a word can't be made with
  # the rack.

  def check_word(word, rack)
    if rack.include?("?") ? blank_tile = true : blank_tile = false
    end
    # Make a copy of rack to use to change values.
    rack_copy = rack.clone
    # result equals true and only goes false if a letter from rack isn't in the word
    result = true
    word.chars do |letter|
      if rack_copy.include?(letter)
        # Find the first instance of letter by its index and delete it at index.
        # This must be down to avoid .include? returning true on a letter multiple
        # times
        rack_copy.delete_at(rack_copy.index(letter))
        # If the letter isn't in rack but theres a blank tile then go back to start
        # of loop
      elsif blank_tile
        # change to false to avoid using blank tile more than once
        blank_tile = false
      # if the letter doesn't exist than turn result to false and break loop
      else
        result = false
        break
      end
    end
    result
  end

  # Get scores of each word
  def word_score(word, rack)
    # set our score to 0
    score = 0
    # loop through each letter and find the score from the list then add it
    # to our total
    word.chars.each do |letter|
        score += SCORES[letter.to_sym]
    end
    # return the total. Add 50 points if the word uses all the rack
    word.length == 7 ? score + 50 : score
  end


  # Check if word is a valid word then add it to our array that we'll return
  def valid_words(rack, words)
    # Load the words
    list_of_words = words
    array_of_valid_words = []
    # for each word check if all the letters of word are in rack
    list_of_words.each do |word|
      array_of_valid_words << word if check_word(word, rack)
    end
    array_of_valid_words
  end

  # Lets find the best words we could use with our rack.

  def find_the_best_words(letters)
    # A hash to store our word and its score
    word_scores = {}
    all_words = all_available_words(letters)
    rack = letters.chars

    # Loop through our list of valid words
    valid_words(rack, all_words).each do |word|
      # Store our score matched to the key of our word
      word_scores[word] = word_score(word, rack)
    end
    # all_words
    # Puts our first 10 word scores sorted from highest to lowest
    word_scores.sort_by { |_key, value| -value}.first(10)
  end

  def all_available_words(rack)
    words = []
    split_rack = rack.chars
    split_rack.combination(2) do |letters|
      words << Word.where(firstLetter: letters[0], secondLetter: letters[1]).map(&:word)
      words << Word.where(firstLetter: letters[1],  secondLetter: letters[0]).map(&:word)
    end
    words.flatten
  end
end
