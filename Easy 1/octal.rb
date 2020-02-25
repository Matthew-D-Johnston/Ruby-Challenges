# octal.rb

class Octal
  def initialize(octal)
    @octal = octal
  end

  def to_decimal
    if valid_octal?
      reversed_digits = @octal.to_i.digits
      decimal = 0
      0.upto(reversed_digits.size - 1) do |n|
        decimal += (8**n) * reversed_digits[n]
      end
      decimal
    else
      0
    end
  end

  def valid_octal?
    !@octal.match?(/\D|[89]/)
  end
end

p Octal.new('1').to_decimal
p Octal.new('10').to_decimal
p Octal.new('17').to_decimal
p Octal.new('11').to_decimal
p Octal.new('130').to_decimal
p Octal.new('0017').to_decimal
p Octal.new('234abc').to_decimal