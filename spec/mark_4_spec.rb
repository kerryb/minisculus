require File.expand_path("../spec_helper", __FILE__)
require "mark_4"

describe Mark4, "set to a and b" do
  it "encodes using simple wheels set to a and -2b, and a memory wheel" do
    wheel_1 = SimpleWheel.new 4
    wheel_2 = SimpleWheel.new -14
    wheel_3 = MemoryWheel.new
    encoder = Mark4.new 4, 7
    text = "aB3!"
    encoder.encode(text).should == text.chars.map do |char|
      new_char = wheel_1.encode char, char
      new_char = wheel_2.encode char, new_char
      wheel_3.encode char, new_char
    end.join
  end
end
