##### Ruby Challenges > Medium 1

---

## Secret Handshake

**Problem:**  

Write a program that will take a decimal number, and convert it to the appropriate sequence of events for a secret handshake.  

There are 10 types of people in the world: Those who understand binary, and those who don't. You and your fellow cohort of those in the "know" when it comes to binary decide to come up with a secret "handshake".  

```ruby
1 = wink
10 = double blink
100 = close your eyes
1000 = jump


10000 = Reverse the order of the operations in the secret handshake.
```

---

**Examples / Test Cases:**  

```ruby
handshake = SecretHandshake.new 9
handshake.commands # => ["wink", "jump"]

handshake = SecretHandshake.new "11001"
handshake.commands # => ["jump", "wink"]
```

The program should consider strings specifying an invalid binary as the value 0.

---

**Data Structure:**

**_Input_**

* An Integer or String object representing a decimal number.

**_Output_**

* An Array object whose elements are String objects representing the actions needed to perform the secret handshake.

**_Rules_**

* The program should consider strings specifying an invalid binary as the value 0.
* Based on the examples it looks as though there are no secret handshake actions for binary numbers with more than 5 digits.

---

**Algorithm:**  

* One of the primary tasks will be to convert the given decimal number to binary.
* After the conversion, we will need to translate the binary numbers into the appropriate actions for the secret handshake.
* For the decimal-to-binary conversion, we will want to use the formula that takes the given decimal number, divides it by 2 and stores the remainder as one of the digits of the binary number. The `divmod` method will come in hand here, as will some form of loop method.
* Let's define a method called `convert_to_binary`:
  * Let's suppose our decimal number is assigned to a local variable called `decimal`.
  * Let's assign the value of `decimal` to a variable called `dividend` (note we do not want `dividend` to be referencing the same object as `decimal`, just the value).
  * Let's initialize a local variable `binary_digits` and assign it to an empty Array object, `[]`.
  * The formula that we will want to loop over will be something like: `dividend, binary_digit = dividend.divmod(2)`.
  * We will want to store the value associated with the `binary_digit` variable in our `binary_digits` array. We can do this with the `unshift` method: `binary_digits.unshift(binary_digit)`.
  * We will want to keep running this loop while `dividend` is greater than 0. Thus, we can use a `while` loop: `while dividend > 0`...

* To deal with strings specifying invalid binarys, we simply take the fact that when using the `to_i` method to convet to an Integer object, a non numeric string will return `0`, which is what the problem says we should treat invalid binarys as.

* When considering the secret handshake code, we should be aware that the code only works for binarys up to five digits. However, to make it apply to binarys with more than five digits we could split any given binary number into five-digit long bits and reapply the handshake code for each bit.

  * To implement

* Now I just need to cycle through each of the segments, starting with the first one, and translate each of the binary numbers into their handshake-action equivalents.

  ----

  **Code:**

  ```ruby
  class SecretHandshake
    SECRET_HS_ACTIONS = ['jump', 'close your eyes', 'double blink', 'wink']  
    
    def initialize(decimal)
      @decimal = decimal
    end
  
    def commands
      binary_segments = five_digit_segments
      command_list = []
      binary_segments.each do |segment|
        if segment[0] == '1'
          command_list << to_actions(segment[1..4]).reverse
        else
          command_list << to_actions(segment[1..4])
        end
      end
  
      command_list.flatten
    end
    
    private
  
    def five_digit_segments
      binary = to_binary
      hs_segments = []
      while binary.length > 5
        hs_segments.unshift(binary[-5..-1])
        binary = binary[0...-5]
      end
  
      hs_segments.unshift(format("%05d", binary))
    end
    
    def to_binary
      if @decimal.instance_of?(Integer)
        dividend = @decimal
        binary_digits = []
  
        while dividend > 0
          dividend, binary_digit = dividend.divmod(2)
          binary_digits.unshift(binary_digit)
        end
  
        binary_digits.join
      else
        @decimal.to_i.to_s
      end
    end
  
    def to_actions(binary)
      actions = []
      4.times do |idx|
        actions.unshift(SECRET_HS_ACTIONS[idx]) if binary[idx] == '1'
      end
      actions
    end
  end
  ```

**Refactored**  

```ruby
class SecretHandshake
  SECRET_HS_ACTIONS = ['jump', 'close your eyes', 'double blink', 'wink'].freeze

  def initialize(decimal)
    @decimal = decimal
  end

  def commands
    binary_segments = five_digit_segments
    command_list = []
    binary_segments.each do |segment|
      command_list << if segment[0] == '1'
                        to_actions(segment[1..4]).reverse
                      else
                        to_actions(segment[1..4])
                      end
    end

    command_list.flatten
  end

  private

  def five_digit_segments
    binary = @decimal.instance_of?(Integer) ? to_binary : @decimal.to_i.to_s
    hs_segments = []
    while binary.length > 5
      hs_segments.unshift(binary[-5..-1])
      binary = binary[0...-5]
    end

    hs_segments.unshift(format('%05d', binary))
  end

  def to_binary
    dividend = @decimal
    binary_digits = []

    while dividend > 0
      dividend, binary_digit = dividend.divmod(2)
      binary_digits.unshift(binary_digit)
    end

    binary_digits.join
  end

  def to_actions(binary)
    actions = []
    4.times do |idx|
      actions.unshift(SECRET_HS_ACTIONS[idx]) if binary[idx] == '1'
    end
    actions
  end
end
```

