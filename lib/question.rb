require "json"

class Question
  attr_reader :uri, :text

  def initialize location
    @uri = URI.parse location
    response = retrieve_resource
    @text = extract_text response.body
  end
  
  private

  def retrieve_resource
    response = Net::HTTP.get_response @uri
    if response.kind_of?(Net::HTTPRedirection)
      @uri.path = response["location"]
      Net::HTTP.get_response @uri
    else
      response
    end
  end

  def extract_text json_body
    data = JSON.parse json_body
    data["question"]
  end
end
