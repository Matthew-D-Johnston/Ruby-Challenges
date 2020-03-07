##### Ruby Challenges > Easy 1

---

## Perfect Number

**Problem:**  

The Greek mathematician Nicomachus devised a classification scheme for natural numbers, identifying each as belonging uniquely to the categories of _abundant, perfect,_ or _deficient_. A perfect number equals the sum of its positive divisors––the pairs of numbers whose product yields the target number, excluding the number itself. This sum is known as the Aliquot sum.  

* Perfect: Sum of factors = number
* Abundant: Sum of factors > number
* Deficient: Sum of factors < number

Write a program that can tell if a number is perfect, abundant or deficient.  

---

**Examples / Test Cases:**  

Examples:  

* 6 is a perfect number because its divisors are 1, 2, 3 and 6 = 1 + 2 + 3.
* 28 is a perfect number because 28 = 1 + 2 + 4 + 7 + 14.
* Prime numbers 7, 13, etc. are deficient by the Nicomachus classification.  

```ruby
PerfectNumber.classify(-1)
# => raises RuntimeError
PerfectNumber.classify(13) == 'deficient'
PerfectNumber.classify(28) == 'perfect'
PerfectNumber.classify(12) == 'abundant'
```

---

**Data Structure:**  

**_Inputs_**

* An Integer object: must be positive, otherwise a `RuntimeError` is raised.

**_Outputs_**

* A String object: either, `'perfect'` , `'abundant'`, or `'deficient'`.

---

* We begin by defining a `PerfectNumber` class.
* This class will have a class method called `classify` which is what we will use to implement our method.
* The `classify` method will be defined with a single parameter, which expects an Integer argument: `def self.classify(number)`.
* We need to find the divisors of the given number. We shall store divisors within a local variable called `divisors`, initialized with the value `[]`.
* Next we will iterate over every number from `1` `upto` the given `number - 1`. Within the block of the `upto` method, we shall divide the `number` by each iterated value of the `upto` method, which will be assigned to a local variable called `candidate`. 
* If the remainder of the division is equal to `0`, then we have a divisor and will store it in our `divisors` array.
* We then sum up all of our divisors and store them to a local variable called `divisors_sum`.



---

**Code:**  

```ruby
class PerfectNumber
  self.classify(number)
  	divisors = []
  	1.upto(number - 1) do |candidate|
      divisors << candidate if number % candidate == 0
    end
  	
  	divisors_sum = divisors.sum
  	if divisors_sum == number
      'perfect'
    elsif divisors_sum > number
      'abundant'
    else
      'deficient'
    end  
	end
end
```

**Refactored:**

```ruby
class PerfectNumber
  def self.classify(number)
    raise RuntimeError if number < 0

    divisors_sum = 0
    1.upto(number - 1) do |candidate|
      divisors_sum += candidate if (number % candidate).zero?
    end

    return 'perfect' if divisors_sum == number

    divisors_sum > number ? 'abundant' : 'deficient'
  end
end
```





