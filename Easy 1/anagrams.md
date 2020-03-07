##### Ruby Challenges > Easy 1

---

## Anagrams

**Programs:**  

Write a program that, given a word and a list of possible anagrams, selects the correct sublist that contains the anagrams of the word.  

For example, given the word `"listen"` and a list of candidates like `"enlists" "google" "inlets" "banana"` the program should return a list containing `"inlets"`. Please read the test suite for exact rules of anagrams.  

---

**Examples / Test Cases:**

```ruby
detector = Anagram.new('diaper')
detector.match(%w(hello world zombies pants)) == []

detector = Anagram.new('ant')
detector.match(%w(tan stand at)) == ['tan']

detector = Anagram.new('master')
detector.match(%w(stream pigeon maters)) == ['maters', 'stream']

detector = Anagram.new('galea')
detector.match(['eagle']) == []

detector = Anagram.new('corn')
detector.match %w(corn dark Corn rank CORN cron park) == ['cron']

detector = Anagram.new('allergy')
detector.match %w( gallery ballerina regally clergy largely leading) == %w(gallery largely regally)
```

---

**Data Structure:**

**_Inputs_**

* A String object.

**_Outputs_**

* An array object whose elements are String object representations of anagrams of the given input, if any.

**_Rules_**

* Valid anagrams must contain the exact same letters as the given word.
* The output should not include the given word.
* The anagram list is case insensitive.

---

**Algorithm:**  

* We should be able to do this by splitting the original word into individual characters, storing them in an array, and then sorting that array by alphabetical order.
* Then, given the list of possible anagrams, we do the same thing to them and compare them with the sorted array of the original array. Any possible anagram whose sorted array matches the original is an anagram.
* We shall define a method called `match` that takes an Array object as an argument: `def match(possible_anagrams)`
* The return value of this method should be an Array object containing all the valid anagrams for the given word; thus, we will store any valid anagram in a variable called `anagrams`, which we will initialize with a beggining value of `[]`. 
* Next, we will split and sort our word, storing it as an Array object and assigned to a local variable called `sorted_word`.
* Then we want to iterate through our given list of `possible_anagrams`, perform the same split and sort of each one, and storing the possible anagram to our `anagrams` array if the result of splitting and sorting returns an Array object whose value is identical to that of our `sorted_word`.

---

**Code:**

```ruby
class Anagram
  def initialize(word)
    @word = word
  end

  def match(possible_anagrams)
    anagrams = []

    possible_anagrams.each do |candidate|
      anagrams << candidate if valid_anagram?(candidate)
    end

    anagrams
  end

  private

  def valid_anagram?(candidate)
    sorted_word = @word.downcase.chars.sort.join
    sorted_candidate = candidate.downcase.chars.sort.join

    sorted_candidate == sorted_word && candidate.downcase != @word.downcase
  end
end
```

**Refactored:**  

```ruby
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
```

