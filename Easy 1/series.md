##### Ruby Challenges > Easy 1

---

## Series

**Problem:**  

Write a program that will take a string of digits and give you all the possible consecutive number series of length n in that strength.  

---

**Examples / Test Cases:**  

For example, the string "01234" has the following 3-digit series:  

```
- 012
- 123
- 234
```

And the following 4-digit series:

```
- 0123
- 1234
```

And if you ask for a 6-digit series from a 5-digit string, you deserve whatever you get (based on the given test suite, asking for an n-digit series that is greater than the number of digits in the string should raise an `ArgumentError`.  

---

**Data Structure:**  

**_Inputs_**  

* A `String` object representation of any number of digits.
* Also, an argument specifying the number of digits to be included in the returned series list.

**_Outputs_**

* Should return an `Array` object containing nested `Arrays`. Those nested `Arrays` should contain elements representing the digits from the original string; each nested `Array` contains the number of elements corresponding to the argument supplied by the user.

**_Rules_**

* The method should raise an `ArgumentError` exception if the argument is greater than the number of digits within the `String`.

---

**Algorithm:**  

* I will start by defining a class called `Series`. When instantiating an object from this class one will need to supply a `String` of digits as an argument to the `new` method.
* The `Series` class will contain a `slices` method. This is the method that will take the `String` and return the nested `Array` objects.
* The `Enumerable#each_cons` method will come in handy here; it essentiallly employs the exact algorithm we are interested in employing. But we will have to initialize a local variable called `series` and assign it to an empty `Array` object. Then, within the block of the `each_cons` method we can push the return value on each iteration of the block to our `series` array.
* We also want to convert each of the digits from `String` objects to `Integer` objects. Thus, the method can start off by taking the given `String` of digits belonging to the particular `Series` object and calling the `chars` method and then chaining the `map` method that will convert each digit to an `Integer` object. We can store this in a variable called `digits`.



---

**Code:**  

```ruby
class Series
  def initialize(number)
    @number = number
  end
  
  def slices(series_size)
    raise ArgumentError if series_size > @number.length
    digits = @number.chars.map { |digit| digit.to_i }
    series = []
    digits.each_cons(series_size) { |slice| series << slice }
    series   
  end
end
```

**Refactoring:**

```ruby
class Series
  def initialize(number)
    @number = number
  end
  
  def slices(series_size)
    raise ArgumentError if series_size > @number.length
    digits = @number.chars.map(&:to_i)
    digits.each_cons(series_size).to_a
  end
end
```



