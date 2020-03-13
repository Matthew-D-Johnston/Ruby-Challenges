# secret_handshake.rb

class SecretHandshake
  SECRET_HS_ACTIONS = ['jump', 'close your eyes', 'double blink', 'wink'].freeze

  def initialize(decimal)
    @decimal = decimal
  end

  def commands
    binary_segments = five_digit_segments
    command_list = []
    binary_segments.each do |segment|
      command_list << if segment[0] == '1'
                        to_actions(segment[1..4]).reverse
                      else
                        to_actions(segment[1..4])
                      end
    end

    command_list.flatten
  end

  private

  def five_digit_segments
    binary = @decimal.instance_of?(Integer) ? to_binary : @decimal.to_i.to_s
    hs_segments = []
    while binary.length > 5
      hs_segments.unshift(binary[-5..-1])
      binary = binary[0...-5]
    end

    hs_segments.unshift(format('%05d', binary))
  end

  def to_binary
    dividend = @decimal
    binary_digits = []

    while dividend > 0
      dividend, binary_digit = dividend.divmod(2)
      binary_digits.unshift(binary_digit)
    end

    binary_digits.join
  end

  def to_actions(binary)
    actions = []
    4.times do |idx|
      actions.unshift(SECRET_HS_ACTIONS[idx]) if binary[idx] == '1'
    end
    actions
  end
end
