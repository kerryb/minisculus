require File.expand_path("../spec_helper", __FILE__)
require "wheel"

describe Wheel do
  describe "encoding" do
    it "rotates the input by the specified number of characters" do
      Wheel.new(3).encode(
        %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
      ).should == %{3456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" 012}
    end
  end
end
