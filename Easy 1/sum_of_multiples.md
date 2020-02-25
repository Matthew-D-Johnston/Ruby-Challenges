##### Ruby Challenges > Easy 1

---

## Sum of Multiples

**Problem:**  

Write a program that, given a number, can find the sum of all the multiples of particular numbers up to but not including that number.  

If we list all the natural numbers up to but not including 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.  

Write a program that can find the sum of the multiples of a given set of numbers. If no set of numbers is given, default to 3 and 5.

---

**Examples / Test Cases:**  

```ruby
SumOfMultiples.to(1)
# => 0
SumOfMultiples.to(4)
# => 3
SumOfMultiples.to(10)
# => 23
SumOfMultiples.to(100)
# => 2318
SumOfMultiples.new(7, 13, 17).to(20)
# => 51
SumOfMultiples.new(4, 6).to(15)
# => 30
SumOfMultiples.new(43, 47).to(10_000)
# => 2203160
```

---

**Data Structure:**  

**_Inputs_**

* Integer objects representing the numbers whose multiples must be summed.
* An Integer object representing the upper limit of the multiples, exclusive of that number.

**_Outputs_**

* An Integer object representing the sum of all the multiples of the given numbers and up until the given limit.

**_Rules_**

* If no arguments are supplied when an object is substantiated, then we use a class method which uses 3 and 5 as the defaults for the multiples.

---

**Algorithm:**  

* We will need to define a `SumOfMultiples` class. This class will take an optional argument when an object is instantiated.
* This class will also have its own `to` class method, which will employ the same algorithm as the `to` instance method but will use the default arguments of `3` and `5`.
* The `to` instance method will be defined with a `limit` parameter:
  * `def to(limit)`
  * We need to initialize a `multiples` local variable and assign it to the value `[]`.
  * We can now iterate through the numbers that were supplied when the `SumOfMultiples` object was instantiated. For each number we will find all the multiples up until the `limit`



---

**Code:**  

```ruby
class SumOfMultiples
  def initialize(*numbers)
    @numbers = numbers
  end
  
  def self.to(limit)
    numbers = [3, 5]
    multiples = []
    numbers.each do |num|
      1.upto((limit - 1) / num) { |n| multiples << num * n }
    end
    multiples.uniq.sum
  end
  
  def to(limit)
		multiples = []
    @numbers.each do |num|
      1.upto((limit - 1) / num) { |n| multiples << num * n }
    end
    multiples.uniq.sum
  end  
end
```

