require File.expand_path("../spec_helper", __FILE__)
require "mark_4"
require "decoder"

describe Decoder do
  it "decodes text encoded by the Mark 4" do
    encoder = Mark4.new 7, 2
    decoder = Decoder.new 7, 2
    original_text = "The quick brown fox jumps over a lazy dog"
    decoder.encode(encoder.encode(original_text)).should == original_text
  end
end
