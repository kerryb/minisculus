require File.expand_path("../spec_helper", __FILE__)
require "question"

describe Question do
  describe "initialising from a URI string" do
    let(:original_uri) { "http://example.com/start" }
    let(:question_path) { "/question" }
    let(:question_uri) { "http://example.com#{question_path}" }
    let(:question_text) { "Hello world!" }

    before do
      stub_request(:get, original_uri).to_return(
        :status => 303,
        :headers => {:location => question_path}
      )
      response_body = {:question => question_text}.to_json
      stub_request(:get, question_uri).to_return :body => response_body
    end

    context "when GETting the URI returns a 303 redirect to a path" do
      let(:question) { Question.new original_uri }

      it "saves the uri it is redicrected to" do
        question.uri.should == URI.parse(question_uri)
      end

      it "extracts the question text" do
        question.text.should == question_text
      end
    end

    context "when GETting the URI returns data" do
      let(:question) { Question.new question_uri }

      it "saves the uri" do
        question.uri.should == URI.parse(question_uri)
      end

      it "extracts the question text" do
        question.text.should == question_text
      end
    end
  end
end
