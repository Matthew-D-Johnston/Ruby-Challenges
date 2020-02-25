# trinary.rb

class Trinary
  def initialize(trinary)
    @trinary = trinary
  end
  
  def to_decimal
    if valid_trinary?
      reversed_digits = @trinary.to_i.digits
      decimal = 0
      reversed_digits.each_with_index do |digit, idx|
        decimal += digit * (3**idx)
      end
      decimal
    else
      0
    end
  end
  
  def valid_trinary?
    !@trinary.match?(/\D|[3-9]/)
  end
end

# p Trinary.new('1').to_decimal
# p Trinary.new('2').to_decimal
# p Trinary.new('10').to_decimal
# p Trinary.new('11').to_decimal
# p Trinary.new('100').to_decimal
# p Trinary.new('112').to_decimal
# p Trinary.new('222').to_decimal
# p Trinary.new('1122000120').to_decimal
# p Trinary.new('carrot').to_decimal
# p Trinary.new('0a1b2c').to_decimal
# p Trinary.new('21023').to_decimal
# p Trinary.new('02012').to_decimal
