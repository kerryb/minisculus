class Encoder
  def encode original_text
    @wheels.inject(original_text) {|encoded_text, wheel| wheel.encode original_text, encoded_text }
  end
end

