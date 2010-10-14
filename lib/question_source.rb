require "json"
require "net/http"

require "question"

module QuestionSource
  def self.get_question url
    uri = URI.parse url
    response = Net::HTTP.get_response uri
    if response.kind_of?(Net::HTTPRedirection)
      uri.merge! response["location"]
      get_question uri.to_s
    else
      create_question uri, response.body
    end
  end

  def self.create_question uri, response_body
    data = JSON.parse response_body
    data["reference-url"] = (uri.merge data["reference-url"]).to_s
    Question.new uri.to_s, data
  end
  private_class_method :create_question
end
