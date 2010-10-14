require File.expand_path("../spec_helper", __FILE__)
require "mark_2"

describe Mark2, "set to a and b" do
  it "encodes using simple wheels set to a and -2b" do
    wheel_1 = SimpleWheel.new 4
    wheel_2 = SimpleWheel.new -14
    encoder = Mark2.new 4, 7
    text = "aB3!"
    encoder.encode(text).should == text.chars.map do |char|
      new_char = wheel_1.encode char, char
      wheel_2.encode char, new_char
    end.join
  end
end
