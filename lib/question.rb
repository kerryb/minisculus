require "json"

class Question
  attr_reader :url, :text

  def initialize url, text
    @url, @text = url, text
  end

  def answer answer
    request = Net::HTTP::Put.new(url.path)
    request.body = {"answer" => answer}.to_json
    request["Content-Type"] = "application/json"
    response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
    if response.kind_of?(Net::HTTPRedirection)
      response["Location"]
    else
      raise "Wrong answer!"
    end
  end
end
