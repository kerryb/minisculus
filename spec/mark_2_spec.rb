require File.expand_path("../spec_helper", __FILE__)
require "mark_2"

describe Mark2 do
  context "when wheel 2 is set to 0" do
    it "rotates the input forwards by the number of characters specified by wheel 1" do
      Mark2.new(3, 0).encode(
        %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
      ).should == %{3456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" 012}
    end
  end

  context "when wheel 1 is set to 0" do
    it "rotates the input backwards by twice the number of characters specified by wheel 2" do
      Mark2.new(0, 3).encode(
        %{0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.,?!'" }
      ).should == %{,?!'" 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.}
    end
  end
end
