# series.rb

# class Series
#   def initialize(number)
#     @number = number
#   end

#   def slices(series_size)
#     raise ArgumentError if series_size > @number.length
#     digits = @number.chars.map(&:to_i)
#     series = []
#     digits.each_cons(series_size) { |slice| series << slice }
#     series
#   end
# end

# Refactored:

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
