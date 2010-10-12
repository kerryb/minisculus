class Encoder
  def encode text
    @wheels.inject(text) {|text, wheel| wheel.encode text }
  end
end

