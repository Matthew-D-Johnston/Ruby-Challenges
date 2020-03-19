##### Ruby Challenges > Easy 2

---

## Odd Words

**Problem:**  

Consider a character set consisting of letters, a space, and a point. Words consist of one or more, but at most 20 letters. An input text consists of one or more words separated from each other by one or more spaces and terminated by 0 or more spaces followed by a point. Input should be read from, and including, the first letter of the first words, up to and including the terminating point. The ouptut text is to be produced such that successive words are separated by a single space with the last word being terminated by a single point. Odd words are copied in reverse order while even words are merely echoed.  

BONUS POINTS: the characters must be read and printed one at a time.

---

**Examples / Test Cases:**  

"whats the matter with kansas." becomes "whats eht matter htiw kansas."

```ruby
sentence = OddWords.new("whats the matter with kansas.")
sentence.odd_words_translation == "whats eht matter htiw kansas."

sentence = OddWords.new("Hey there silly   goose .")
sentence.odd_words_translation == "Hey ereht silly esoog."
```

---

**Data Structure:**  

**_Input_**

* A String object consisiting of words separated by one or more spaces and a terminating point, or period.

**_Output_**

* A String object representation of the input string, but with words separated by single spaces and the final word terminated by a period. Also, beginning from the left, every odd-numbered word should read backwards (i.e the letters are in reverse order).

---

**Algorithm:**  

* One of the first things we want to do is isolate just the words of the input so that we can work on those without having to figure out what to do with the final period. We know that the output will take a final point or period at the end of the final word. Since the input only consists of one point we can use the `delete('.')` method.
* We can then split the string into separate words with the `split` method.
* We should then be able to iterate over those words while we apply the `reverse` method to words whose index in the array are odd.
* Let's also add a method to check for invalid inputs; we shall call this method `invalid?`
  * Some invalid cases:
    * `''` -- no point or letters; `match?(/\s/)`
    * `'.'` -- no letters; `match?(/\./)`
    * `'hello'` -- no space or point
    * A string with a word containing more than 20 letters.
    * Anything other than letters, spaces, or points; `match?(/[^a-z.\s]/i)`
  * 
  * 

**Bonus:**

* We need to include a method that takes a single word and then ouputs each character in order.
* We'll call this method `output_char(word)`
  * take a string, split it into individual characters, then iterate over each character and output it to the screen.

---

**Code:**  

```ruby
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
```

**Bonus:**

```ruby
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
```

