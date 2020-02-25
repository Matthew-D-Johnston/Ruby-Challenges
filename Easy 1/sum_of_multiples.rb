# sum_of_multiples.rb

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

# p SumOfMultiples.to(1) == 0
# p SumOfMultiples.to(4) == 3
# p SumOfMultiples.to(10) == 23
# p SumOfMultiples.to(100) == 2318
# p SumOfMultiples.new(7, 13, 17).to(20) == 51
# p SumOfMultiples.new(4, 6).to(15) == 30
# p SumOfMultiples.new(43, 47).to(10_000) == 2_203_160
