require "json"

require "question"

module QuestionSource
  def self.get_question location
    url = URI.parse location
    response = Net::HTTP.get_response url
    if response.kind_of?(Net::HTTPRedirection)
      url.path = response["location"]
      get_question url.to_s
    else
      text = extract_text response.body
      Question.new url, text
    end
  end

  def self.extract_text json_body
    data = JSON.parse json_body
    data["question"]
  end
  private_class_method :extract_text
end
