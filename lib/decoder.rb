require "encoder"
require "simple_wheel"
require "reverse_memory_wheel"

class Decoder < Encoder
  def initialize wheel_1_setting, wheel_2_setting
    @wheels = [
      SimpleWheel.new(-wheel_1_setting),
      SimpleWheel.new(2 * wheel_2_setting),
      ReverseMemoryWheel.new
    ]
  end
end
