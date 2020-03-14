##### Ruby Challenges > Medium 1

---

## Luhn Algorithm

**Problem:**  

The Luhn formula is a simple checksum formula used to validate a variety of identification numbers, such as credit card numbers and Canadian Social Insurance Numbers.

The formula verifies a number against its included check digit, which is usually appended to a partial number to generate the full number. This number must pass the following test:

- Counting from rightmost digit (which is the check digit) and moving left, double the value of every second digit.
- For any digits that thus become 10 or more, subtract 9 from the result.
  - 1111 becomes 2121.
  - 8763 becomes 7733 (from 2×6=12 → 12-9=3 and 2×8=16 → 16-9=7).
- Add all these digits together.
  - 1111 becomes 2121 sums as 2+1+2+1 to give a checksum of 6.
  - 8763 becomes 7733, and 7+7+3+3 is 20.

If the total (the checksum) ends in 0 (put another way, if the total modulus 10 is congruent to 0), then the number is valid according to the Luhn formula; else it is not valid. So, 1111 is not valid (as shown above, it comes out to 6), while 8763 is valid (as shown above, it comes out to 20).

Write a program that, given a number

- Can check if it is valid per the Luhn formula. This should treat, for example, "2323 2005 7766 3554" as valid.
- Can return the checksum, or the remainder from using the Luhn method.
- Can add a check digit to make the number valid per the Luhn formula and return the original number plus that digit. This should give "2323 2005 7766 3554" in response to "2323 2005 7766 355".

About Checksums:

A checksum has to do with error-detection. There are a number of different ways in which a checksum could be calculated.

When transmitting data, you might also send along a checksum that says how many bytes of data are being sent. That means that when the data arrives on the other side, you can count the bytes and compare it to the checksum. If these are different, then the data has been garbled in transmission.

In the Luhn problem the final digit acts as a sanity check for all the prior digits. Running those prior digits through a particular algorithm should give you that final digit.

It doesn't actually tell you if it's a real credit card number, only that it's a plausible one. It's the same thing with the bytes that get transmitted -- you could have the right number of bytes and still have a garbled message. So checksums are a simple sanity-check, not a real in-depth verification of the authenticity of some data. It's often a cheap first pass, and can be used to quickly discard obviously invalid things.

---

**Examples / Test Cases:**  

```ruby
luhn = Luhn.new(12_121)
luhn.addends == [1, 4, 1, 4, 1]

luhn = Luhn.new(8631)
luhn.addends == [7, 6, 6, 1]

luhn = Luhn.new(4913)
luhn.checksum == 22

luhn = Luhn.new(201_773)
luhn.checksum == 21

luhn = Luhn.new(738)
luhn.valid? == false

luhn = Luhn.new(8_739_567)
luhn.valid? == true

Luhn.create(123) == 1230

Luhn.create(873_956) == 8_739_567

Luhn.create(837_263_756) == 8_372_637_564
```

---

**Data Structure:**  

**_Input_**

* The input to the `new` method when instantiating a new Luhn object is an Integer object.
* All of the instance methods--`addends`, `checksum`, and `valid?`--also take this Integer object as their calling object (i.e. their input).
* There is also a `create` class method that also takes an Integer object.

**_Output_**

* `addends`: an Array object whose elements contain Integer objects representing the result of doubling the value of every second digit starting from the rightmost digit.
* `checksum`: an Integer object represnting the sum of the digits populating the Array object returned by the `addends` method.
* `valid?`: a boolean value: `true` if the number is valid and `false` otherwise.
* `create`: an Integer object that represents a valid number created from a non-valid number.

---

**Algorithm:**

* Let's start with defining the `Luhn` class.
* The `initialize` method will be defined with a single parameter, `number`.
* When a new Luhn object is instantiated an Integer object will need to be passed to the `new` method and will be assigned to the local variable `number`, which the `initialize` method will then assign to the `@number` instance variable.
* We shall begin by defining the `addends` method since the other methods will depend on it.
  * `def addends`
  * Use the `digits` array on the `@number` instance variable. Note that this will split the given number into its individual digits and will also reverse the order of those digits, which will be helpful.
  * Next use the `map.with_index` method call on the new array created above.
  * Within the method block we will want to take any odd numbered index and multiply the given digit for that index by `2`
  * This will return a new array object that we will then want to use the `reverse` method on to get the digits back into the original order.

* Now we need to define the `checksum` method:
  * `checksum` will use the return value of the `addends` method.
  * It will simply sum up the values of the individual digits conatined within the Array object returned by `addends`.
* Now we need to define the `valid?` method.
  * This method will make use of the return value of the `checksum` method.
  * It will return `true` if the following conditions are met: `checksum % 10 == 0`.
* Now we need to define the `create` class method:
  * `def self.create(number)`
  * To start off we will create a new Luhn object and assign it to the local variable `luhn`. This will allow us to make use of the instance methods we defined earlier within this new `create` class method.
  * We will want to use an `if/else` conditional to check if the given number is valid. If it is, then we can simply return the given number; otherwise we will have to append an additional digit to make it valid.
  * To do this we will want to run a loop where we append a digit, starting at 0, and then check to see if the resulting number is valid: if it is valid then the loop can stop, otherwise we continue running the loop until we get a valid number.



---

**Code:**  

```ruby
class Luhn
  def initialize(number)
    @number = number
  end

  def addends
    @number.digits.map.with_index do |digit, idx|
      if idx.odd?
        digit * 2 > 9 ? (digit * 2) - 9 : digit * 2
      else
        digit
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(number)
    luhn = new(number)
    valid_number = number
    append = 0

    until luhn.valid?
      valid_number = (number.to_s << append.to_s).to_i
      luhn = new(valid_number)
      append += 1
    end

    valid_number
  end
end
```

