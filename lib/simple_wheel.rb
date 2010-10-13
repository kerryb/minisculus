require "wheel"
require "encoder"

class SimpleWheel < Wheel
  def initialize setting
    @setting = setting
  end

  def encode keyed_char, partially_encoded_char
    shift partially_encoded_char
  end
end
