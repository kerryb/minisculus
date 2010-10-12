require "encoder"
require "simple_wheel"

class Mark2 < Encoder
  def initialize wheel_1_setting, wheel_2_setting
    @wheels = [
      SimpleWheel.new(wheel_1_setting),
      SimpleWheel.new(-2 * wheel_2_setting)
    ]
  end
end
