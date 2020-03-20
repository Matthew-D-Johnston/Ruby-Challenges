##### Ruby Challenges > Easy 2

---

## Beer Song

**Problem:**  

Write a program that can generate the lyrics of the 99 Bottles of Beer song. See the test suite for the entire song.

---

**Examples / Test Cases:**  

```ruby
BeerSong.new.verse(99) == "99 bottles of beer on the wall, 99 bottles of beer.\n" \
      "Take one down and pass it around, 98 bottles of beer on the wall.\n"

BeerSong.new.verse(3) == "3 bottles of beer on the wall, 3 bottles of beer.\n" \
      "Take one down and pass it around, 2 bottles of beer on the wall.\n"

BeerSong.new.verses(99, 98) == "99 bottles of beer on the wall, 99 bottles of beer.\n" \
      "Take one down and pass it around, 98 bottles of beer on the wall.\n" \
      "\n" \
      "98 bottles of beer on the wall, 98 bottles of beer.\n" \
      "Take one down and pass it around, 97 bottles of beer on the wall.\n"

BeerSong.new.verses(2, 0) == "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n" \
      "\n" \
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n" \
      "\n" \
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"

BeerSong.new.lyrics == # prints every verse starting from 99 all the way down to 0.
```

---

**Data Structure:**  

**_Input_**

* Any of the `verse` methods take one or more Integer objects correpsonding to the verse number of the song.

**_Output_**

* Any of the `verse` methods will output the verse corresponding to the number given as the input.
* For the `lyrics` method, the entire song will be printed.

**_Rules_**

* To fulfill the bonus requirement, we cannot use any `if` or `case` statements.

---

**Algorithm:**  

* I think it will be helpful to define some methods containing the string representation of the verses for the four different types of verses:  1) verse 0, which is the closing verse; 2) verse 1 which will need to change any of the wording; 3) verse 2 which will have a slighly different wording; and 4) any of the other verses which will be generic from 3 up until 99.
* 

---

**Code:**

```ruby
class BeerSong
  def verse(number)
    verse_collection(number)[number]
  end

  def verses(start, finish)
    verses_string = ''
    start.downto(finish + 1) do |num|
      verses_string << verse(num) << "\n"
    end
    verses_string << verse(finish)
  end

  def lyrics
    verses(99, 0)
  end

  private

  def verse_collection(qty)
    verse_array = [verse_0, verse_1, verse_2]
    3.upto(qty) do |num|
      verse_array << verse_x(num)
    end
    verse_array
  end

  def verse_0
    "No more bottles of beer on the wall, no more bottles of beer.\n" \
    "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  def verse_1
    "1 bottle of beer on the wall, 1 bottle of beer.\n" \
    "Take it down and pass it around, no more bottles of beer on the wall.\n"
  end

  def verse_2
    "2 bottles of beer on the wall, 2 bottles of beer.\n" \
    "Take one down and pass it around, 1 bottle of beer on the wall.\n"
  end

  def verse_x(qty)
    "#{qty} bottles of beer on the wall, #{qty} bottles of beer.\n" \
    "Take one down and pass it around, #{qty - 1} bottles of beer on the wall.\n"
  end
end
```

