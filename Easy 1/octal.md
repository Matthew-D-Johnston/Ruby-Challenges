##### Ruby Challenges > Easy 1

---

## Octal

**Problem:**  

Implement octal to decimal conversion. Given an octal input string, your program should produce a decimal output.  

**Note:** Implement the conversion yourself. Do not use something else to perform the conversion for you. Treat invalid input as octal 0.  

About Octal (Base - 8):  

Decimal is a base-10 system.  

A number 233 in base 10 notation can be understood as a linear combination of power of 10:  

* The rightmost digit gets multiplied by 10^0 = 1
* The next number gets multiplied by 10^1 = 10
* ...
* The nth number gets multiplied by 10^n-1.
* All these values are summed.

So:  

```ruby
233 # decimal
= 2*10^2 + 3*10^1 + 3*10^0
= 2*100 + 3*10 + 3*1
```

Octal is similar, but uses powers of 8 rather than powers of 10. So:  

```ruby
233 # octal
= 2*8^2 + 3*8^1 + 3*8^0
= 2*64  + 3*8   + 3*1
= 128   + 24    + 3
= 155
```

---

**Test Cases / Examples:**

```ruby
Octal.new('1').to_decimal
# => 1
Octal.new('10').to_decimal
# => 8
Octal.new('17').to_decimal
# => 15
Octal.new('11').to_decimal
# => 9
Octal.new('130').to_decimal
# => 88
Octal.new('2047').to_decimal
# => 1063
Octal.new('carrot').to_decimal
# => 0
Octal.new('8').to_decimal
# => 0
Octal.new('9').to_decimal
# => 0
Octal.new('6789').to_decimal
# => 0
Octal.new('011').to_decimal
# => 9
```

---

**Data Structure:**  

**_Inputs_**

* A String object representation of an octal number.

**_Outputs_**

* An Integer object represnting the conversion of the given octal input to a decimal output.

**_Rules_**

* Any invalid input should output `0`.
* Invalid input includes any number that includes an 8 or a 9, and any alphabetical character.
* If the input contains a leading zero or zeros, this is still considered a valid input--just remove the leading zero(s).

---

**Algorithm:**  

* Will need to create an `Octal` class. Objects instantiated from this class must supply a String object representation of an octal number.
* We will need to include a `to_decimal` method that does the conversion from octal to decimal.
* The `to_decimal` method will employ the use of a `valid_octal?` method.
* If `valid_octal?` returns true then we employ the conversion algorithm; otherwise we return `0`.
* The conversion algorithm consists of the following:
  * Use the `to_i` method to convert  String object to an Integer object and then call the `digits` method to split individual digits into elements of an array; note that `digits` reverses the order of the digits, and this is what we want. We can assign the return value of these operations to a local variable called `reversed_digits`.
  * Let's initialize a `decimal` variable and assign it the value of `0`.
  * Use the `upto` method to iterate from `0` up until the total number of digits minus 1 (`reversed_digits.size - 1`).
  * We can use the numeric iterations of the `upto` method as the powers and as the index of the `reversed_digits` array.
  * We thus employ the conversion algorithm where we raise 8 to the current power and multiply it by current element of the `reversed_digits` array.
* The `valid_octal?` method will employ a regex, that will cause the method to return `false` for any String object that contains an alphabetical character, an 8, and/or a 9. 



---

**Code:**  

```ruby
class Octal
  def initialize(octal)
    @octal = octal
  end
  
  def to_decimal
    if valid_octal?
      reversed_digits = @octal.to_i.digits
      decimal = 0
      0.upto(reversed_digits.size - 1) do |n|
        decimal += (8**n) * reversed_digits[n]
      end
      decimal
    else
      0
    end
  end
  
  def valid_octal?
    !@octal.match?(/\D|[89]/)
  end
end
```

