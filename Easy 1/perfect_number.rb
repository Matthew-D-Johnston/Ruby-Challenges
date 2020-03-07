# perfect_number.rb

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
