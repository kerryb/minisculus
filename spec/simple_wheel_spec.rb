require File.expand_path("../spec_helper", __FILE__)
require "simple_wheel"

describe SimpleWheel do
  describe "encoding" do
    it "rotates the input by the specified number of characters" do
      offset = 3
      wheel = SimpleWheel.new offset
      chars = %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }.chars.to_a
      chars.each_with_index do |char, index|
        wheel.encode(char, char).should == chars[(index + offset) % chars.length]
      end
      #SimpleWheel.new(3).encode(
        #"", %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
      #).should == %{3456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" 012}
    end
  end
end
