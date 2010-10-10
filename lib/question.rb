require "json"

class Question
  attr_reader :uri, :text

  def initialize location
    @uri = URI.parse location
    response = Net::HTTP.get_response @uri
    if response.kind_of?(Net::HTTPRedirection)
      @uri.path = response["location"]
      puts "Redirected to #{@uri.inspect}"
      response = Net::HTTP.get_response @uri
    end
    @text = extract_text response.body
  end
  
  private

  def extract_text json_body
    data = JSON.parse json_body
    data["question"]
  end
end
