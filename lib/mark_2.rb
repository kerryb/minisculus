require "encoder"

class Mark2 < Encoder
  def initialize wheel_1_setting, wheel_2_setting
    @wheels = [
      Wheel.new(wheel_1_setting),
      Wheel.new(-2 * wheel_2_setting)
    ]
  end
end
