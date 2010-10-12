require File.expand_path("../spec_helper", __FILE__)
require "mark_1"

describe Encoder do
  it "encodes the txt with each wheel in turn" do
    wheel_1 = double :wheel_1
    wheel_1.stub(:encode).with("foo", "foo").and_return "bar"
    wheel_2 = double :wheel_1
    wheel_2.stub(:encode).with("foo", "bar").and_return "baz"

    class TestEncoder < Encoder
      def initialize *wheels
        @wheels = wheels
      end
    end

    TestEncoder.new(wheel_1, wheel_2).encode("foo").should == "baz"
  end
end
