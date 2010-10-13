require "encoder"

class MemoryWheel
  def initialize
    @setting = 0
  end

  def encode keyed_char, partially_encoded_char
    position = Encoder::Keys.find_index partially_encoded_char
    encoded_char = Encoder::Keys[(position + @setting) % Encoder::Keys.length]
    @setting = 2 * Encoder::Keys.find_index(keyed_char)
    encoded_char
  end
end
