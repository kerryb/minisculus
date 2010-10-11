require "json"

class Question
  attr_reader :uri, :text

  def initialize uri, text
    @uri, @text = uri, text
  end

  def answer answer
    request = Net::HTTP::Put.new(uri.path)
    request.body = {"answer" => answer}.to_json
    request["Content-Type"] = "application/json"
    response = Net::HTTP.new(uri.host, uri.port).start {|http| http.request(request) }
    if response.kind_of?(Net::HTTPRedirection)
      response["Location"]
    else
      raise "Wrong answer!"
    end
  end
end
