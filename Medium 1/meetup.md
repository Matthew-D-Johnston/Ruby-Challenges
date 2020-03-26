##### Ruby Challenges > Medium 1

---

## Meetup

**Problem:**  

Typically meetups happen on the same day of the week.  

Examples are:  

* the first Monday
* the third Tuesday
* the Wednesteenth
* the last Thursday



Note that "Monteenth", "Tuesteenth", etc. are all made up words. There was a meetup whose members realised that there are exactly 7 days that end in '-teenth'. Therefore, one is guaranteed that each day of the week (Monday, Tuesday, ...) will have exactly one date that is named with '-teenth' in every month.  

Write code that calculates date of meetups.  

Define a `Meetup` class:

* constructor method (i.e. `initialize`) parameters: month and a year
* `day` method parameters: weekday (e.g. monday) and schedule (e.g. first, second, third, fourth, last, or teenth).

---

**Examples / Test Cases:**

```ruby
Meetup.new(5, 2013).day(:monday, :teenth) == Date.new(2013, 5, 13)
Meetup.new(3, 2013).day(:tuesday, :teenth) == Date.new(2013, 3, 19)
Meetup.new(7, 2013).day(:wednesday, :first) == Date.new(2013, 7, 3)
Meetup.new(10, 2013).day(:thursday, :first) == Date.new(2013, 10, 3)
Meetup.new(11, 2013).day(:friday, :second) == Date.new(2013, 11, 8)
Meetup.new(2, 2013).day(:saturday, :third) == Date.new(2013, 2, 16)
Meetup.new(3, 2013).day(:sunday, :fourth) == Date.new(2013, 3, 24)
Meetup.new(3, 2013).day(:monday, :last) == Date.new(2013, 3, 25)
```

---

**Data Structure:**  

**_Inputs_**

* The constructor `initialize` method for instantiating a Meetup object will take two Integer objects as arguments: the first specifies the month of the year and the second specifies the year.
* The `day` method will take two Symbol object arguments: one specifying the day of the week and the second indicating which part of the month (i.e. first week, second week, etc.).

**_Outputs_**

* The `day` method should output a Date object that uses the month and year supplied by the user when the Meetup object was instantiated and then selects the correct day based on the arguments input to the `day` method.

---

**Algorithm:**

* We will need to `require 'date'` for this program.
* Begin by constructing the `Meetup` class with the `initialize` method that will initialize two instance variables and set them to the values specified by the method's parameters.
* Next, we begin defining the `day` method with the parameters `weekday` and `schedule`.
* One way to solve this is to take the given month and year and then to cycle through each day of the month, focusing on the weekday specified by the `day` method; we will include a counter to that will allow us to keep track of whether it is the first, second, third, fourth, teenth, or last of that particular weekday. We will need a special condition for teenth, and will have to realize that teenth may overlap with some of the other categories.
* Actually, since we know what the `schedule` is, when we cycle through the days we only need to cycle through that portion of the month. For example, if the `schedule` argument is `:first`, we need only cycle through the days 1 to 7; for `:teenth` we need only cycle through 13 to 19; for `:last` we need only cycle through 29 to 31. We could possibly use a `case` statement to structure this.
* We will then cycle through the various dates specified by the schedule, creating new Date objects until we find the one that matches the day of the week. We can try something like: `(8..14).select { |day| Date.new(2013, 5, day).monday? }`
* Based on some experiments, we need to rethink `:last` since it corresponds to the last week not just the last days that are not included in the fourth week. This means it will overlap with some of the days in the fourth week but we will also need to change it up based on the actual number of days in the month, since not all months have the same number of days. It appears that the following will give me the number of days in the month, `Date.new(year, month, -1).day`

---

**Code:**

```ruby
require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(weekday, schedule)
    case schedule
    when :first
      range = (1..7)
      create_date(weekday, range)
    when :second
      range = (8..14)
      create_date(weekday, range)
    when :third
      range = (15..21)
      create_date(weekday, range)
    when :fourth
      range = (22..28)
      create_date(weekday, range)
    when :teenth
      range = (13..19)
      create_date(weekday, range)
    when :last
      end_range = Date.new(@year, @month, -1).day
      begin_range = end_range - 6
      range = (begin_range..end_range)
      create_date(weekday, range)
    end
  end

  def create_date(weekday, range)
    case weekday
    when :monday
      date = range.select { |day| Date.new(@year, @month, day).monday? }
      Date.new(@year, @month, date.first)
    when :tuesday
      date = range.select { |day| Date.new(@year, @month, day).tuesday? }
      Date.new(@year, @month, date.first)
    when :wednesday
      date = range.select { |day| Date.new(@year, @month, day).wednesday? }
      Date.new(@year, @month, date.first)
    when :thursday
      date = range.select { |day| Date.new(@year, @month, day).thursday? }
      Date.new(@year, @month, date.first)
    when :friday
      date = range.select { |day| Date.new(@year, @month, day).friday? }
      Date.new(@year, @month, date.first)
    when :saturday
      date = range.select { |day| Date.new(@year, @month, day).saturday? }
      Date.new(@year, @month, date.first)
    when :sunday
      date = range.select { |day| Date.new(@year, @month, day).sunday? }
      Date.new(@year, @month, date.first)
    end
  end
end
```

**Refactored:**

```ruby
require 'date'

class Meetup
  def initialize(month, year)
    @month = month
    @year = year
    @last_last_day = Date.new(@year, @month, -1).day
    @first_last_day = @last_last_day - 6
  end

  def day(weekday, schedule)
    case schedule
    when :first then create_date(weekday, 1, 7)
    when :second then create_date(weekday, 8, 14)
    when :third then create_date(weekday, 15, 21)
    when :fourth then create_date(weekday, 22, 28)
    when :teenth then create_date(weekday, 13, 19)
    when :last then create_date(weekday, @first_last_day, @last_last_day)
    end
  end

  def create_date(weekday, first_day, last_day)
    date = nil

    first_day.upto(last_day) do |day|
      test_date = Date.new(@year, @month, day)
      day_of_week = test_date.strftime('%A').downcase
      date = test_date if day_of_week.to_sym == weekday
    end

    date
  end
end
```

