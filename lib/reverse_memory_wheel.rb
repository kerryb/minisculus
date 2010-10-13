require "wheel"
require "encoder"

class ReverseMemoryWheel < Wheel
  def initialize
    @setting = 0
  end

  def encode keyed_char, partially_encoded_char
    encoded_char = shift partially_encoded_char
    @setting = -2 * Encoder::Keys.find_index(encoded_char)
    encoded_char
  end
end
