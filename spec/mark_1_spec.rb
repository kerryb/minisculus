require File.expand_path("../spec_helper", __FILE__)
require "mark_1"

describe Mark1, "set to a" do
  it "encodes using a simple wheel set to a" do
    wheel = SimpleWheel.new 4
    encoder = Mark1.new 4
    text = "aB3!"
    encoder.encode(text).should == text.chars.map do |char|
      wheel.encode char, char
    end.join
  end
end
