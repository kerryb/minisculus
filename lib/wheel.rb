class Wheel
  protected

  def shift char
    position = Encoder::Keys.find_index char
    encoded_char = Encoder::Keys[(position + @setting) % Encoder::Keys.length]
  end
end
