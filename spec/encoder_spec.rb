require File.expand_path("../spec_helper", __FILE__)
require "mark_1"

describe Encoder do
  describe "Keys" do
    it do
      Encoder::Keys.should == [
        "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
        "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
        "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
        "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
        ".", ",", "?", "!", "'", "\"", " "
      ]
    end
  end

  describe "#encode" do
    it "encodes the text a letter at a time through each wheel" do
      wheel_1 = double :wheel_1
      wheel_1.stub(:encode).with("a", "a").and_return "A"
      wheel_1.stub(:encode).with("b", "b").and_return "B"
      wheel_2 = double :wheel_1
      wheel_2.stub(:encode).with("a", "A").and_return "b"
      wheel_2.stub(:encode).with("b", "B").and_return "c"

      class TestEncoder < Encoder
        def initialize *wheels
          @wheels = wheels
        end
      end

      TestEncoder.new(wheel_1, wheel_2).encode("ab").should == "bc"
    end
  end
end
