##### Ruby Challenges > Easy 1

---

## Trinary

**Problem:**  

Write a program that will convert a trinary number, represented as a string (e.g. '102012'), to its decimal equivalent using first principles (without using an existing method or library that can work with numeral systems).  

Trinary numbers can only contain three symbols: 0, 1, and 2. Invalid trinary entries should convert to decimal number 0.  

The last place in a trinary number is the 1's place. The second to last is the 3's place, the third to last is the 9's place, etc.  

```ruby
# "102012"
		1 			0 			2 			0 			1 			2 	# the number
1*3^5 + 0*3^4 + 2*3^3 + 0*3^2 + 1*3^1 + 2*3^0		# the value
	243 + 		0 + 	 54 + 		0 + 	  3 + 		2 = 302
```

---

**Examples / Test Cases:**  

```ruby
Trinary.new('1').to_decimal
# => 1
Trinary.new('2').to_decimal
# => 2
Trinary.new('10').to_decimal
# => 3
Trinary.new('11').to_decimal
# => 4
Trinary.new('100').to_decimal
# => 9
Trinary.new('112').to_decimal
# => 14
Trinary.new('222').to_decimal
# => 26
Trinary.new('1122000120').to_decimal
# => 32_091
Trinary.new('carrot').to_decimal
# => 0
Trinary.new('0a1b2c').to_decimal
# => 0
```

---

**Data Structure:**  

**_Inputs_**

* A String representation of a trinary number.

**_Outputs_**

* An Integer representation of the conversion from a trinary number to a decimal number.

**_Rules_**

* For the input to be valid it must contain only the digits 0, 1, and/or 2. Any other input that includes something other than these digits should return `0`.

---

**Algorithm:**

* We will define a `Trinary` class. Instantiating an object from this class will require us to input a String representation of a trinary number.
* This class will contain a `to_decimal` method that performs the conversion from trinary to decimal.
* We will also need to employ a `valid_trinary?` method that will ensure that the only digits within the input are either 0, 1, or 2.
* The `valid_trinary?` method can be implemented in the following way:
  * `!@trinary.match?(/\D|[3-9]/)`
* The `to_decimal` method can be implemented in the following way:
  * Check to see if the input is a valid trinary using the `valid_trinary?` method.
  * If valid, then employ the conversion algorithm; otherwise, return `0`.
  * Initialize a `reversed_digits` variable and assign it to the return value of a `to_i` method call and `digits` method call on the String representation of the trinary number.
  * Initialize a `decimal` local variable and assign it to the value of `0`.
  * Then call the `each_with_index` method on the `reversed_digits` array. Within the block we employ the following algorithm: `decimal += digit * (3**index)`.

---

**Code:**  

```ruby
class Trinary
  def initialize(trinary)
    @trinary = trinary
  end
  
  def to_decimal
    if valid_trinary?
      reversed_digits = @trinary.to_i.digits
      decimal = 0
      reversed_digits.each_with_index do |digit, idx|
        decimal += digit * (3**idx)
      end
      decimal
    else
      0
    end
  end
  
  def valid_trinary?
    !@trinary.match?(/\D|[3-9]/)
  end
end
```

