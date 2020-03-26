# meetup.rb

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
