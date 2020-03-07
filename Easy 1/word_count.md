##### Ruby Challenges > Easy 1

----

## Word Count

**Problem:**  

Write a program that given a phrase can count the occurrence of each word in that phrase.  

For example, if we count the words for the input "olly olly in come free", we should get:  

```
1 | olly: 2
2 | in: 1
3 | come: 1
4 | free: 1
```

---

**Examples / Test Cases:**  

```ruby
phrase = Phrase.new('word')
phrase.word_count == { 'word' => 1 }

phrase = Phrase.new('one of each')
phrase.word_count == { 'one' => 1, 'of' => 1, 'each' => 1 }

phrase = Phrase.new('one fish two fish red fish blue fish')
phrase.word_count == { 'one' => 1, 'fish' => 4, 'two' => 1, 'red' => 1, 'blue' => 1 }

phrase = Phrase.new('car : carpet as java : javascript!!&@$%^&')
phrase.word_count == { 'car' => 1, 'carpet' => 1, 'as' => 1, 'java' => 1, 'javascript' => 1 }

phrase = Phrase.new("one,\ntwo,\nthree")
phrase.word_count == { 'one' => 1, 'two' => 1, 'three' => 1 }

phrase = Phrase.new("First: don't laugh. Then: don't cry.")
phrase.word_count == { 'first' => 1, "don't" => 2, 'laugh' => 1, 'then' => 1, 'cry' => 1 }

phrase = Phrase.new("Joe can't tell between 'large' and large.")
phrase.word_count == { 'joe' => 1, "can't" => 1, 'tell' => 1, 'between' => 1, 'large' => 2, 'and' => 1 }
```

---

**Data Structure:**

**_Inputs_**

* A String object.

**_Outputs_**

* A Hash object containing String objects as keys, which represent words from the original String object, and Integer objects as values representing the number of times each particular word occurs in the original String object.

**_Rules_**

* Words are case insensitive (i.e. `go` and `Go` represent two occurences of the word 'go').

---

**Algorithm:**  

* We need to begin by defining a `Phrase` class that whenever a new Phrase object is instantiated we must pass a String object in as an argument to the `new` method.
* We need a way to split the String object into individual words: `@phrase.split(/[^a-z0-9']/i)`
* Let's start by defining a `words` method that will take our `@phrase` instance variable that is assigned to our String object. This `words` method will return an Array object containing all of the words that will need to be counted.
* Then we can define the `word_count` method that will utilize our `words` method.
* 



---

**Code:**  

```ruby
class Phrase
  def initialize(string)
    @phrase = string
  end
  
  def word_count
    words.each_with_object({}) do |word, count|
      count[word] ? count[word] += 1 : count[word] = 1
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
```

**Refactored:**

```ruby
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
```

---

**Further Exploration:**

Examine below the following three solutions to the above problem:

###### Solution 1

```ruby
class Phrase
  def initialize(words)
    @words = words
  end

  def word_count
    count = Hash.new(0)

    @words.scan(/\b[\w']+\b/) do |word|
      count[word.downcase] += 1
    end

    count
  end
end
```

###### Solution 2

```ruby
class Phrase
  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words_in_phrase.each_with_object(Hash.new(0)) do |word, results|
      results[word] += 1
    end
  end

  private

  def words_in_phrase
    @phrase.downcase.scan(/\w+'?\w+|\w+/)
  end
end
```

###### Solution 3

```ruby
class Phrase
  def initialize(phrase)
    @words = phrase.downcase.scan(/[a-z]+'?[a-z]+|\d+/)
  end

  def word_count
    @words.each_with_object(Hash.new(0)) do |word, results|
      results[word] += 1
    end
  end
end
```

All 3 of the provided solutions have a small problem: if a word *ends* with an apostrophe (for instance, `Louis' classroom`), they will strip the apostrophe instead of including it in the word. Write a test to check for this condition, and use it to test your own program. If necessary, fix your code so it keeps the trailing apostrophes.

**My Test Assertion:**

```ruby
def test_handles_trailing_apostrophe
  phrase = Phrase.new("Louis' classroom")
  counts = { "louis'" => 1, 'classroom' => 1 }
  assert_equal counts, phrase.word_count
end
```

My original code already passes this test.





