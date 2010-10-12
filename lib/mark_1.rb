require "encoder"

class Mark1 < Encoder
  def initialize setting
    @wheels = [Wheel.new setting]
  end
end
