require File.expand_path("../spec_helper", __FILE__)
require "mark_1"

describe Mark1 do
  it "rotates the input by the specified number of characters" do
    Mark1.new(3).encode(
      %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
    ).should == %{3456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" 012}
  end
end
