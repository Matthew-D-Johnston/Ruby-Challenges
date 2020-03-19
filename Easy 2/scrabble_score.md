##### Ruby Challenges > Easy 2

---

## Scrabble Score

**Problem:**  

Write a program that, given a word, computes the scrabble score for that word.

###### Letter Values  

You'll need these:

```
Letter													Value
A, E, I, O, U, L, N, R, S, T			1
D, G															2
B, C, M, P												3
F, H, V, W, Y											4
K																	5
J, X															8
Q, Z															10
```

---

**Examples / Test Cases:**  

"cabbage" should be scored as worth 14 points:

* 3 points for C
* 1 point for A, twice
* 3 points for B, twice
* 2 points for G
* 1 point for E

And to total:  

* `3 + 2*1 + 2*3 + 2 + 1`
* = `3 + 2 + 6 + 3`
* = `5 + 9`
* = 14

```ruby
Scrabble.new('').score == 0
Scrabble.new(" \t\n").score == 0
Scrabble.new(nil).score == 0
Scrabble.new('a').score == 1
Scrabble.new('f').score == 4
Scrabble.new('street').score == 6
Scrabble.new('quirky').score == 22
Scrabble.new('OXYPHENBUTAZONE').score == 41
Scrabble.new('alacrity').score == 13
```

---

**Data Structure:**  

**_Input_**

* A String object representation of a word.

**_Output_**

* An Integer object representing the Scrabble score for the given input.

**_Rules_**

* Case insensitive.
* Invalid inputs should receive a score of `0`.

---

**Algorithm:**  

* The first thing to do is to create a  `RUBRIC` constant assigned to a Hash object whose keys represent the letters of the alphabet and whose values represent the points associated with each letter.
* Within the `score` method we will `return` a value of `0` `unless` we have a `valid?` word.
* Our `valid?` method will return `true` if `word.match?(/\A\b[a-z]+$/i)`
* Now we can move to evaluating valid words.
* We should iterate over each letter of the word, transforming it to its Scrabble point equivalent, and then sum each of those points to get the total score.



---

**Code:**

```ruby
class Scrabble
  RUBRIC = { 'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2, 'E' => 1,
             'F' => 4, 'G' => 2, 'H' => 4, 'I' => 1, 'J' => 8,
             'K' => 5, 'L' => 1, 'M' => 3, 'N' => 1, 'O' => 1,
             'P' => 3, 'Q' => 10, 'R' => 1, 'S' => 1, 'T' => 1,
             'U' => 1, 'V' => 4, 'W' => 4, 'X' => 8, 'Y' => 4,
             'Z' => 10 }.freeze

  def initialize(word)
    @word = word
  end

  def score
    valid_word? ? @word.chars.map { |letter| RUBRIC[letter.upcase] }.sum : 0
  end

  def valid_word?
    @word =~ /\A\b[a-z]+$/i
  end
end
```





