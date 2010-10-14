require "json"
require "net/http"

class Question
  class WrongAnswer < StandardError; end

  attr_reader :url

  def initialize url, params
    @url = url
    @params = params
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

  def method_missing name
    @params[name.to_s.gsub("_", "-")] or super
  end
end
