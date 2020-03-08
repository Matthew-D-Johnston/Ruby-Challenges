##### Ruby Challenges > Easy 1

---

## Roman Numerals

**Problem:**  

The Romans were a clever bunch. They conquered most of Europe and ruled it for hundreds of years. They invented concrete and straight roads and even bikinis. One thing they never discovered though was the number zero. This made writing and dating extensive histories of their exploits slightly more challenging, but the system of numbers they came up with is still in use today. For example the BBC uses Roman numerals to date their programmes.  

The Romans wrote numbers using letters––I, V, X, L, C, D, M. (notice these letters have lots of straight lines and are hence easy to hack into stone tablets).

```
1 => I
10 => X
7 => VII
```

There is no need to be able to convert numbers larger than about 3000. (The Romans themselves didn't tend to go any higher)  

Wikipedia says: Modern Roman numerals ... are written by expressing each digit separately starting with the left most digit and skipping any digit with a value of zero.  

To see this in practice, consider the example of 1990. In Roman numerals 1990 is MCMXC:  

```
1000=M
900=CM
90=XC
```

2008 is written as MMVIII:

```
2000=MM
8=VIII
```

See also: [http://www.novaroma.org/via_romana/numbers.html](http://www.novaroma.org/via_romana/numbers.html)

---

**Examples / Test Cases:**

```ruby
1.to_roman == 'I'
2.to_roman == 'II'
3.to_roman == 'III'
4.to_roman == 'IV'
5.to_roman == 'V'
6.to_roman == 'VI'
9.to_roman == 'IX'
27.to_roman == 'XXVII'
48.to_roman == 'XLVIII'
59.to_roman == 'LIX'
93.to_roman == 'XCIII'
141.to_roman == 'CXLI'
163.to_roman == 'CLXIII'
402.to_roman == 'CDII'
575.to_roman == 'DLXXV'
911.to_roman == 'CMXI'
1024.to_roman == 'MXXIV'
3000.to_roman == 'MMM'
```

---

**Data Structure:**  

**_Inputs_**

* An Integer object.

**_Outputs_**

* A String object representing the Roman numeral equivalent of the given Integer input.

**_Rules_**

* No need to go higher than the number 3000.

----

**Algorithm:**  

Let's start begin with a key for the various Roman letters and their numerical equivalents:

```
I = 1
V = 5
X = 10
L = 50
C = 100
D = 500
M = 1000
```

* The method will have four main segments, one each for the 1000s, 100s, 10s, and 1s.
* For the 1000s digits we have:

```
0 => ignore
1 => M
2 => MM
3 => MMM
digit > 3 => "Does not convert higher than three thousand."
```

* For the 100s digits we have:

```
0 => ignore
1 => C
2 => CC
3 => CC
4 => CD
5 => D
6 => DC
7 => DCC
8 => DCCC
9 => CM
```

* For the 10s digits we have:

```
0 => ignore
1 => X
2 => XX
3 => XXX
4 => XL
5 => L
6 => LX
7 => LXX
8 => LXXX
9 => XC
```

* For the 1s digits we have:

```
0 => ignore
1 => I
2 => II
3 => III
4 => IV
5 => V
6 => VI
7 => VII
8 => VIII
9 => IX
```

* We will start the `to_roman` method off with a statement that will return the following line `"Does not compute for numbers greater than 3000"` if the given input is an integer greater than 3000.
* We will modify the `Integer` class by adding the `to_roman` method. 
* We will also create constant variables for each of the four classes of digits above and assign them to hashes: the keys will be the integers, and the values will be the roman numeral equivalents.



----

**Code:**  

```ruby
class Integer
  THOUSANDS = { 0 => '', 1 => 'M', 2 => 'MM', 3 => 'MMM' }
  HUNDREDS = { 0 => '', 1 => 'C', 2 => 'CC', 3 => 'CCC', 4 => 'CD',
               5 => 'D', 6 => 'DC', 7 => 'DCC', 8 => 'DCCC', 9 => 'CM'
             }
  TENS = { 0 => '', 1 => 'X', 2 => 'XX', 3 => 'XXX', 4 => 'XL',
               5 => 'L', 6 => 'LX', 7 => 'LXX', 8 => 'LXXX', 9 => 'XC'
         }
  ONES = { 0 => '', 1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV',
               5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX'
         }
  
  def to_roman
    return "This method does not compute Roman numerals for numbers " +
           "greater than 3000." if self > 3000
    
    roman_numerals = ''
    digits = 1000
    digit, remainder = self.divmod(digits)
    
    loop do
      case digits
      when 1000
        roman_numerals += THOUSANDS[digit]
      when 100
        roman_numerals += HUNDREDS[digit]
      when 10
        roman_numerals += TENS[digit]
      when 1
        roman_numerals += ONES[digit]
      end 
      
      break if digits == 1
      digits /= 10
      digit, remainder = remainder.divmod(digits)
    end
    
    roman_numerals
  end 
end
```

**Refactored:**  

```ruby
class Integer
  THOUSANDS = { 0 => '', 1 => 'M', 2 => 'MM', 3 => 'MMM' }.freeze
  HUNDREDS = { 0 => '', 1 => 'C', 2 => 'CC', 3 => 'CCC', 4 => 'CD',
               5 => 'D', 6 => 'DC', 7 => 'DCC', 8 => 'DCCC', 9 => 'CM' }.freeze
  TENS = { 0 => '', 1 => 'X', 2 => 'XX', 3 => 'XXX', 4 => 'XL',
           5 => 'L', 6 => 'LX', 7 => 'LXX', 8 => 'LXXX', 9 => 'XC' }.freeze
  ONES = { 0 => '', 1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV',
           5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX' }.freeze

  def to_roman
    return 'Number must be between 0 and 3000.' if self > 3000

    roman_numerals = ''
    digits = 1000
    remainder = self

    until digits.zero?
      digit, remainder = remainder.divmod(digits)
      roman_numerals += roman_digits(digit, digits)
      digits /= 10
    end

    roman_numerals
  end

  def roman_digits(digit, digits)
    case digits
    when 1000 then THOUSANDS[digit]
    when 100  then HUNDREDS[digit]
    when 10   then TENS[digit]
    when 1    then ONES[digit]
    end
  end
end
```

