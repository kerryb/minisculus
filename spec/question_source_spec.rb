require File.expand_path("../spec_helper", __FILE__)
require "question_source"

describe QuestionSource do
  describe "getting a question" do
    let(:original_url) { "http://example.com/start" }
    let(:question_path) { "/question" }
    let(:question_url) { "http://example.com#{question_path}" }
    let(:question_text) { "Hello world!" }

    before do
      stub_request(:get, original_url).to_return(
        :status => 303,
        :headers => {:location => question_path}
      )
      response_body = {:question => question_text}.to_json
      stub_request(:get, question_url).to_return :body => response_body
    end

    shared_examples_for "getting a question" do
      it "saves the url" do
        question.url.should == URI.parse(question_url)
      end

      it "extracts the question text" do
        question.text.should == question_text
      end
    end

    context "when GETting the URI returns a 303 redirect to a path" do
      let(:question) { QuestionSource.get_question original_url }

      it_should_behave_like "getting a question"
    end

    context "when GETting the URI returns data" do
      let(:question) { QuestionSource.get_question question_url }

      it_should_behave_like "getting a question"
    end
  end
end
