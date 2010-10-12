require "json"
require "net/http"

class Question
  class WrongAnswer < StandardError; end

  attr_reader :url, :reference_url, :text

  def initialize url, reference_url, text
    @url = url
    @reference_url = URI.parse(url).merge(reference_url).to_s
    @text = text
  end

  def answer answer
    uri = URI.parse url
    request = Net::HTTP::Put.new(uri.path)
    request.body = {"answer" => answer}.to_json
    request["Content-Type"] = "application/json"
    response = Net::HTTP.new(uri.host, uri.port).start {|http| http.request(request) }
    if response.kind_of?(Net::HTTPRedirection)
      response["Location"]
    else
      raise WrongAnswer.new response.body
    end
  end
end
