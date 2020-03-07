# word_count.rb

class Phrase
  def initialize(string)
    @phrase = string
  end

  def word_count
    words.each_with_object(Hash.new(0)) do |word, count|
      count[word] += 1
    end
  end

  private

  def words
    word_array = @phrase.split(/[^a-z0-9']/i)
    word_array.delete("")
    word_array.map do |word|
      word = word[1..-2] if word[0] == "'" && word[-1] == "'"
      word.downcase
    end
  end
end
