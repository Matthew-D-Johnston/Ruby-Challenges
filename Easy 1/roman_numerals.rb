# roman_numerals.rb

class Integer
  THOUSANDS = { 0 => '', 1 => 'M', 2 => 'MM', 3 => 'MMM' }.freeze
  HUNDREDS = { 0 => '', 1 => 'C', 2 => 'CC', 3 => 'CCC', 4 => 'CD',
               5 => 'D', 6 => 'DC', 7 => 'DCC', 8 => 'DCCC', 9 => 'CM' }.freeze
  TENS = { 0 => '', 1 => 'X', 2 => 'XX', 3 => 'XXX', 4 => 'XL',
           5 => 'L', 6 => 'LX', 7 => 'LXX', 8 => 'LXXX', 9 => 'XC' }.freeze
  ONES = { 0 => '', 1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV',
           5 => 'V', 6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX' }.freeze

  def to_roman
    return 'Number must be between 0 and 3000.' if self > 3000

    roman_numerals = ''
    digits = 1000
    remainder = self

    until digits.zero?
      digit, remainder = remainder.divmod(digits)
      roman_numerals += roman_digits(digit, digits)
      digits /= 10
    end

    roman_numerals
  end

  def roman_digits(digit, digits)
    case digits
    when 1000 then THOUSANDS[digit]
    when 100  then HUNDREDS[digit]
    when 10   then TENS[digit]
    when 1    then ONES[digit]
    end
  end
end
