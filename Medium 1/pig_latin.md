##### Ruby Challenges > Medium 1

---

## Pig Latin

**Problem:**  

Pig Latin is a made-up children's language that's intended to be confusing. It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.  

* **Rule 1:** If a word begins with a vowel sound, add an "ay" sound to the end of the word.
* **Rule 2:** If a word begins with a consonant sound, move it to the end of the word, and then add an "ay" sound to the end of the word.

There are a few more rules for edge cases, and there are regional variants too.

---

**Examples / Test Cases:**  

```ruby
PigLatin.translate('apple') == 'appleay'
PigLatin.translate('ear') == 'earay'
PigLatin.translate('pig') == 'igpay'
PigLatin.translate('koala') == 'oalakay'
PigLatin.translate('chair') == 'airchay' # note the consonant block 'ch'
PigLatin.translate('queen') == 'eenquay'
PigLatin.translate('square') == 'aresquay' # note the consonant block and 'qu'
PigLatin.translate('therapy') == 'erapythay' # note the consonant block 'th'
PigLatin.translate('thrush') == 'ushthray' # note the consonant block 'thr'
PigLatin.translate('school') == 'oolschay' # note the consonant block 'sch'
PigLatin.translate('quick fast run') == 'ickquay astfay unray' # note the 'qu'
PigLatin.translate('yellow') == 'ellowyay'
PigLatin.translate('yttria') == 'yttriaay' # note the 'y' treated as a vowel
PigLatin.translate('xenon') == 'enonxay' # note the x' before a vowel (consonant sound)
PigLatin.translate('xray') == 'xrayay' # note the 'x' before a consonant (vowel sound)
```

---

**Data Structure:**  

**_Input_**

* A String object representation of one or more words.

**_Output_**

* A String object representation of the input string transalted into Pig Latin.

---

**Algorithm:**

* We will need to begin by defining a `PigLatin` class.
* This class will have a class method called `translate`, which will do the translation from English into Pig Latin.
* This `translate` method will need to be defined with a single parameter, which will allow for a String-object argument to be passed to the `translate` method: `def self.translate(english)`
* This method will need to perform a number of functions: 
  * first, we will need to determine whether the initial letters produce a consonant or value sound, whether they are consonant blocks, and how to treat  the two special edge cases of `'q'` and `'x'`;
  * secondly, based on result of the first operation, we will then need to actually transform the given input string to its appropriate Pig-Latin transaltion.
* For the first operation, let's think about possible cases:
  * strings that begin with a vowel or a 'y': `match(/\b[aeiouy]/i)`
  * strings that begin with any number of consonants up until the first vowel: `match(/\b[bcdfghjklmnpqrstvwxz]+/i)`
  * strings that begin with any number of consonants followed by a `'qu'`: `match(/\b[bcdfghjklmnpqrstvwxz]*qu/i)`
  * strings that begin with an `'x'` and then a vowel: `match(/\bx[aeiouy]/i)`
  * strings that begin with an `'x'` and then a consonant: `match(/\bx[bdcfghjklmnpqrstvwxz]/i)`
* The following will cover all the cases that we will want a match for: `match(/\b([bcdfghjklmnpqrstvwxz]*qu|(x|y)[aeiouy]|[bcdfghjklmnpqrstvwz]+)/i)`
* However, based on the algorithm I want to implement I think that I will need to treat x's and y's as separate cases. I will also need a special case to treat strings with more than one word.
* But for the normal case we have the following regex: `/\b([bcdfghjklmnpqrstvwxz]*qu|[bcdfghjklmnpqrstvwz]+)/i`
* For the x's and y's we have: `/\b(x|y)[aeiou]/i`; since the actual match will include the value, which we do not want to displace, we will have to put in a special condition that only extracts the first element of the match and appends it to the end of the word.



---

**Code:**  

```ruby
class PigLatin
  def self.translate(english)
    words = english.split
    words.map do |word|
      if word.match(/\b(x|y)[aeiou]/i)
        result = word.match(/\b(x|y)[aeiou]/i)
        result.to_s[1] + result.post_match + result.to_s[0] + 'ay'
      else
        result = word.match(/\b([bcdfghjklmnpqrstvwxz]*qu|[bcdfghjklmnpqrstvwz]+)/i)
        result == nil ? word + 'ay' : result.post_match + result.to_s + 'ay'
      end
    end.join(' ')
  end
end
```

**Refactored:**

```ruby
class PigLatin
  def self.translate(words)
    words.split.map do |word|
      if word =~ /\b(x|y)[aeiou]/i
        x_and_y_scenario(word)
      else
        regular_scenario(word)
      end
    end.join(' ')
  end

  def self.regular_scenario(str)
    result = str.match(/\b([bcdfghjklmnpqrstvwxz]*qu|[bcdfghjklmnpqrstvwz]+)/i)
    result.nil? ? str + 'ay' : result.post_match + result.to_s + 'ay'
  end

  def self.x_and_y_scenario(str)
    result = str.match(/\b(x|y)[aeiou]/i)
    result.to_s[1] + result.post_match + result.to_s[0] + 'ay'
  end
end
```



