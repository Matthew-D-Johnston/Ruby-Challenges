##### Ruby Challenges > Easy 1

---

## Sieve of Eratosthenes

**Problem:**  

Write a program that uses the Sieve of Eratosthenes to find all the primes from 2 up to a given number.  

The Sieve of Eratosthenes is a simple, ancient algorithm for finding all prime numbers up to any given limit. It does so by iteratively marking as composite (i.e. not prime) the multiples of each prime, starting with the multiples of 2.  

Create your range, starting at two and continuing up to and including the given limit. (i.e. [2, limit]).  

The algorithm consists of repeating the following over and over:

* take the next available unmarked number in your list (it is prime)
* mark all the multiples of that number (they are not prime)  

Repeat until you have processed each number in your range. When the algorithm terminates, all the numbers in the list that have not been marked are prime. The [wikipedia article](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes) has a useful graphic that explains the algorithm.  

Notice that this is a very specific algorithm, and the tests don't check that you've implemented the algorithm, only that you've come up with the correct list of primes.  

---

**Examples / Test Cases:**  

```ruby
Sieve.new(10).primes
# => [2, 3, 5, 7]
Sieve.new(13).primes
# => [2, 3, 5, 7, 11, 13]
```

---

**Data Structure:**  

**_Inputs_**

* An Integer object representing the upper limit for our list of primes.

**_Outputs_**

* An Array object whose elements are all the prime numbers from 2 up to the limit supplied.

**_Rules_**

* Must construct the algorithm based on the Sieve of Eratosthenes.

---

**Algorithm:**  

* Create an empty Array object assigned to the local variable `composites`.
* Create another empty Array object assigned to the local variable `primes`.
* Use the `upto` method to iterate over all numbers from 2 until the given limit: `2.upto(limit)`
* Check to see if the `composites` array includes the current number. If not, then add that number to the `primes` Array and add all multiples of that number to the `composites` array; otherwise skip that number and go to the next.

---

**Code:**

```ruby
class Sieve
  def initialize(limit)
    @limit = limit
  end
  
  def primes
    primes = []
    composites = []
    2.upto(@limit) do |number|
      if composites.include?(number)
        next
      else
        primes << number
        2.upto(@limit / number) { |multiple| composites << number * multiple }
      end
    end
    
    primes
  end
end
```

A more explicit "marking" of primes as "prime" and composites as "composite":

```ruby
class Sieve
  def initialize(limit)
    @limit = limit
  end
  
  def primes
    results = Hash.new(0)

    2.upto(@limit) do |number|
      if results[number] == "composite"
        next
      else
        results[number] = "prime"
        2.upto(@limit / number) do |multiple|
          results[number * multiple] = "composite"
        end
      end
    end
    
    primes = []
    results.each { |key, value| primes << key if value == "prime" }
    primes
  end
end
```

