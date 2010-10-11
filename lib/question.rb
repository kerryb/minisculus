require "json"

class Question
  attr_reader :uri, :text

  def initialize uri, text
    @uri, @text = uri, text
  end
end
