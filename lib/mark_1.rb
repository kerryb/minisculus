require "encoder"
require "simple_wheel"

class Mark1 < Encoder
  def initialize setting
    @wheels = [SimpleWheel.new setting]
  end
end
