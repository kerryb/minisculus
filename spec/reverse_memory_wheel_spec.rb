require File.expand_path("../spec_helper", __FILE__)
require "reverse_memory_wheel"

describe ReverseMemoryWheel do
  describe "encoding" do
    let(:wheel) { ReverseMemoryWheel.new }

    context "the first letter" do
      it "leaves it unchanged" do
        wheel.encode("X", "a").should == "a"
      end
    end

    context "subsequent letters" do
      it "rotates the input backwards by the twice the index of the previous encoded letter" do
        wheel.encode("X", "1")
        wheel.encode("Y", "c").should == "a"
      end
    end
  end
end
