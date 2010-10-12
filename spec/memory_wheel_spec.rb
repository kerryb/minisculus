require File.expand_path("../spec_helper", __FILE__)
require "memory_wheel"

describe MemoryWheel do
  describe "encoding" do
    let(:wheel) { MemoryWheel.new }

    context "the first letter" do
      it "leaves it unchanged" do
        wheel.encode("a", "a").should == "a"
      end
    end

    context "subsequent letters" do
      it "rotates the input by the twice the index of the previous keyed letter" do
        wheel.encode("ABC", "AAA").should == "AUW"
      end
    end
  end
end
