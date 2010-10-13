require "wheel"
require "encoder"

class MemoryWheel < Wheel
  def initialize
    @setting = 0
  end

  def encode keyed_char, partially_encoded_char
    encoded_char = shift partially_encoded_char
    @setting = 2 * Encoder::Keys.find_index(keyed_char)
    encoded_char
  end
end
