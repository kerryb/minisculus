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

  describe "answering" do
    let(:this_question_uri) { "http://example.com/foo" }
    let(:next_question_uri) { "http://example.com/bar" }
    let(:question) { Question.new URI.parse(this_question_uri), "some text" }
    let(:answer) { "some more text" }
    let(:answer_as_json) { {:answer => answer}.to_json }

    before do
      stub_request(:put, this_question_uri).to_return(
        :status => 303,
        :headers => {"Location" => next_question_uri}
      )
    end

    it "PUTs the answer back to the same URI" do
      question.answer answer
      WebMock.should have_requested(:put, this_question_uri).with(
        :body => answer_as_json,
        :headers => {"Content-Type" => "application/json"}
      )
    end

    context "correctly" do
      it "returns the URI of the next question" do
        question.answer(answer).should == next_question_uri
      end
    end

    context "incorrectly" do
      before do
        stub_request(:put, this_question_uri).to_return(:status => 406)
      end

      it "raises an exception" do
        lambda { question.answer answer }.should raise_error("Wrong answer!")
      end
    end
  end  
end
