require File.expand_path("../spec_helper", __FILE__)
require "question"

describe Question do
  describe "initialising with a url and text" do
    let(:url) { URI.parse "http://example.com/foo" }
    let(:text) { "What is your favourite colour?" }
    let(:question) { Question.new url, text }

    it "saves the url" do
      question.url.should == url
    end

    it "extracts the question text" do
      question.text.should == text
    end
  end

  describe "answering" do
    let(:this_question_url) { "http://example.com/foo" }
    let(:next_question_url) { "http://example.com/bar" }
    let(:question) { Question.new URI.parse(this_question_url), "some text" }
    let(:answer) { "some more text" }
    let(:answer_as_json) { {:answer => answer}.to_json }

    before do
      stub_request(:put, this_question_url).to_return(
        :status => 303,
        :headers => {"Location" => next_question_url}
      )
    end

    it "PUTs the answer back to the same URI" do
      question.answer answer
      WebMock.should have_requested(:put, this_question_url).with(
        :body => answer_as_json,
        :headers => {"Content-Type" => "application/json"}
      )
    end

    context "correctly" do
      it "returns the URI of the next question" do
        question.answer(answer).should == next_question_url
      end
    end

    context "incorrectly" do
      before do
        stub_request(:put, this_question_url).to_return(:status => 406)
      end

      it "raises an exception" do
        lambda { question.answer answer }.should raise_error("Wrong answer!")
      end
    end
  end  
end
