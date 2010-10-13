require "encoder"

class SimpleWheel
  def initialize setting
    @setting = setting
  end

  def encode keyed_char, partially_encoded_char
    position = Encoder::Keys.find_index partially_encoded_char
    Encoder::Keys[(position + @setting) % Encoder::Keys.length]
  end
end
