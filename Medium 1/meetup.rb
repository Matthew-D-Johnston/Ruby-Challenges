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
    create_date(weekday, day_range(schedule))
  end

  private

  def create_date(weekday, days)
    the_day = "#{weekday}?".to_sym
    days.map { |day| Date.new(@year, @month, day) }.select(&the_day).first
  end

  def day_range(schedule)
    case schedule
    when :first then 1..7
    when :second then 8..14
    when :third then 15..21
    when :fourth then 22..28
    when :teenth then 13..19
    when :last then @first_last_day..@last_last_day
    end
  end
end
