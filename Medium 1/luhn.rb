# luhn.rb

class Luhn
  def initialize(number)
    @number = number
  end

  def addends
    @number.digits.map.with_index do |digit, idx|
      if idx.odd?
        digit * 2 > 9 ? (digit * 2) - 9 : digit * 2
      else
        digit
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(number)
    luhn = new(number)
    valid_number = number
    append = 0

    until luhn.valid?
      valid_number = (number.to_s << append.to_s).to_i
      luhn = new(valid_number)
      append += 1
    end

    valid_number
  end
end
