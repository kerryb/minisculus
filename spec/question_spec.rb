require File.expand_path("../spec_helper", __FILE__)
require "question"

describe Question do
  describe "initialising with a url, relative reference_url, text and code" do
    let(:url) { "http://example.com/foo" }
    let(:relative_reference_url) { "/help.html" }
    let(:absolute_reference_url) { "http://example.com/help.html" }
    let(:text) { "What is your favourite colour?" }
    let(:code) { "What is your favourite colour?" }
    let(:question) { Question.new url, relative_reference_url, text, code }

    it "saves the url" do
      question.url.should == url
    end

    it "saves the absolute reference_url" do
      question.reference_url.should == absolute_reference_url
    end

    it "extracts the question text" do
      question.text.should == text
    end
  end

  describe "answering" do
    let(:this_question_url) { "http://example.com/foo" }
    let(:next_question_url) { "http://example.com/bar" }
    let(:question) { Question.new this_question_url, "/ref", "some text", nil }
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
      let(:body) { "Sorry, try again." }

      before do
        stub_request(:put, this_question_url).to_return(:status => 406, :body => body)
      end

      it "raises an exception containing the response body" do
        lambda { question.answer answer }.should raise_error(Question::WrongAnswer, body)
      end
    end
  end
end
