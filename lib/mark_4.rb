require "encoder"
require "simple_wheel"
require "memory_wheel"

class Mark4 < Encoder
  def initialize wheel_1_setting, wheel_2_setting
    @wheels = [
      SimpleWheel.new(wheel_1_setting),
      SimpleWheel.new(-2 * wheel_2_setting),
      MemoryWheel.new
    ]
  end
end
