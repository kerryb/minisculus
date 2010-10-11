require File.expand_path("../spec_helper", __FILE__)
require "question"

describe Question do
  describe "initialising with a uri and text" do
    let(:uri) { URI.parse "http://example.com/foo" }
    let(:text) { "What is your favourite colour?" }
    let(:question) { Question.new uri, text }

    it "saves the uri" do
      question.uri.should == uri
    end

    it "extracts the question text" do
      question.text.should == text
    end
  end
end
