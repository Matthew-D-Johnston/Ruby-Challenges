# odd_words.rb

class OddWords
  def initialize(string)
    @string = string
  end

  def odd_words_translation
    return @string unless valid?

    words = @string.clone.delete('.').split
    odd_words = []

    words.each_with_index do |word, idx|
      idx.odd? ? odd_words << word.reverse : odd_words << word
    end

    odd_words.join(' ') << "."
  end

  def valid?
    other_chars = @string.match?(/[^a-z.\s]/i)
    spaces = @string.match?(/ /)
    points = @string.match?(/\./)
    letters = @string.match?(/[a-z]/i)
    more_than_20 = @string.match?(/[a-z]{21,}/i)
    spaces && points && letters && !other_chars && !more_than_20
  end
end


# Bonus:

class OddWords
  def initialize(string)
    @string = string
  end

  def odd_words_translation
    return @string unless valid?
    words = @string.clone.delete('.').split
    number_of_words = words.size

    words.each_with_index do |word, idx|
      if idx.odd?
        output_chars(word.reverse)
      else
        output_chars(word)
      end
      print ' ' if idx < (number_of_words - 1)
    end

    puts '.'
  end

  def output_chars(word)
    word.chars.each do |char|
      print char
      sleep 0.1
    end
  end

  def valid?
    other_chars = @string.match?(/[^a-z.\s]/i)
    spaces = @string.match?(/ /)
    points = @string.match?(/\./)
    letters = @string.match?(/[a-z]/i)
    more_than_20 = @string.match?(/[a-z]{21,}/i)
    spaces && points && letters && !other_chars && !more_than_20
  end
end

sentence = OddWords.new('whats the matter with kansas.')
p sentence.valid? == true
sentence.odd_words_translation #== "whats eht matter htiw kansas."
sentence = OddWords.new("Hey there silly   goose .")
p sentence.valid? == true
sentence.odd_words_translation #== "Hey ereht silly esoog."
sentence = OddWords.new('')
p sentence.valid? == false
sentence.odd_words_translation #== ''
sentence = OddWords.new('.')
p sentence.valid? == false
sentence.odd_words_translation #== '.'
sentence = OddWords.new('hello')
p sentence.valid? == false
p sentence.odd_words_translation #== 'hello'
sentence = OddWords.new("hello my friend in the worldworldworldworldd hi.")
p sentence.valid? == false
sentence.odd_words_translation #== "hello my friend in the worldworldworldworldd hi."
sentence = OddWords.new("hello my friend in the worldworldworldworld hi.")
p sentence.valid? == true
sentence.odd_words_translation
sentence = OddWords.new("hello hello")
p sentence.valid?