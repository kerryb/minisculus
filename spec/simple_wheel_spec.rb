require File.expand_path("../spec_helper", __FILE__)
require "simple_wheel"

describe SimpleWheel do
  describe "encoding" do
    it "rotates the input by the specified number of characters" do
      SimpleWheel.new(3).encode(
        "", %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
      ).should == %{3456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" 012}
    end
  end
end
