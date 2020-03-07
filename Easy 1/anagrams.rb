# anagrams.rb

class Anagram
  def initialize(word)
    @word = word
  end

  def match(possible_anagrams)
    possible_anagrams.select do |candidate|
      valid_anagram?(candidate)
    end
  end

  private

  def valid_anagram?(candidate)
    sorted_word = @word.downcase.chars.sort
    sorted_candidate = candidate.downcase.chars.sort

    sorted_candidate == sorted_word && !candidate.casecmp(@word).zero?
  end
end
