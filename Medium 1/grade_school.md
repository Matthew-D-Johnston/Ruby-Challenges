##### Ruby Challenges > Medium 1

---

## Grade School

**Problem:**  

Write a small archiving program that stores students' names along with the grade that they are in.

In the end, you should be able to:

- Add a student's name to the roster for a grade
  - "Add Jim to grade 2."
  - "OK."
- Get a list of all students enrolled in a grade
  - "Which students are in grade 2?"
  - "We've only got Jim just now."
- Get a sorted list of all students in all grades. Grades should sort as 1, 2, 3, etc., and students within a grade should be sorted alphabetically by name.

```ruby
{1=>["Anna", "Barb", "Charlie"], 2=>["Alex", "Peter"], ...}
```

The excat output format doesn't matter: what's important is that it shows all of the students and grades in the proper order.  

Note that all our students only have one name. (It's a small town, what do you want?).

---

**Examples / Test Cases:**

```ruby
school = School.new
school.to_h == {}

school = School.new
school.add('Aimee', 2)
school.to_h == { 2 => ['Aimee'] }

school = School.new
school.add('Blair', 2)
school.add('James', 2)
school.add('Paul', 2)
school.to_h == { 2 => %w(Blair James Paul) }

school = School.new
school.add('Chelsea', 3)
school.add('Logan', 7)
school.to_h == { 3 => ['Chelsea'], 7 => ['Logan'] }

school = School.new
school.add('Bradley', 5)
school.add('Franklin', 5)
school.add('Jeff', 1)
school.grade(5) == %w(Bradley Franklin)

school = School.new
school.grade(1) == []

school = School.new
[['Jennifer', 4], ['Kareem', 6],['Christopher', 4], ['Kyle', 3]].each do |name, grade|
	school.add(name, grade)
end
```

---

**Data Structure:**

**_Inputs_**

* No input when instantiating a new School object.
* The `to_h` method will simply take all of the students and there corresponding grades.
* The `add` method will take a String object representing the name of the student and an Integer object representing the student's grade.
* The `grade` method will take an Integer object representing the grade for which the user is interested in seeing the students.

**_Outputs_**

* The `to_h` method will output a hash of all the students: the keys will the grades in ascending order and the values will be array of students names listed in alphabetical order.
* The `add` method will add a student to the hash collection. The return value is somewhat irrelevant.
* The `grade` method will return an array of all the students in the specified grade and in alphabetical order. If there are no students in that grade then an empty array will be returned.

---

**Algorithm:**

* On instantiation we will initialize an `@students` instance variable and assign it to an empty hash, `{}`.
* The `add` method will check to see if there is a value associated with the given key specified by the grade that is input to the method: if no value exists then the key will be created using the grade specified and it will be assigned to a value that has the specified name within an Array object; otherwise, if the value does exist, the name will simply be shoved, `<<`, to the existing array.
* We will then sort the elements of the array for that particular value.
* The `grade` method will check to see if a value exists for a given key specified by the grade number as the method's output: if it exists, we simply return the array of all students from that grade (the array is already sorted from the `add` method); otherwise, if there is no value and associated key, we return an empty array, `[]`.
* The `to_h` method will take our hash assigned to the `@students` instance variable and return it. We must first sort it, and because the `sort` method on a Hash object returns an Array object, we simply need to call the `Array#to_h` method on that sorted array to get our `School#to_h` method to return a Hash object that has been sorted by keys, which are Integer objects.

---

**Code:**  

```ruby
class School
  def initialize
    @students = {}
  end

  def to_h
    @students.sort.to_h
  end

  def add(name, grade)
    @students[grade] ? @students[grade] << name : @students[grade] = [name]
    @students[grade].sort!
  end

  def grade(grd)
    @students[grd] ? @students[grd] : []
  end
end
```

**Refactored:**

```ruby
class School
  def initialize
    @students = {}
  end

  def to_h
    @students.sort.to_h
  end

  def add(name, grade)
    @students[grade] ? @students[grade] << name : @students[grade] = [name]
    @students[grade].sort!
  end

  def grade(grd)
    @students[grd] || []
  end
end
```

