#!/usr/bin/env ruby

require "rubygems"
require "net/http"
require "json"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"

keys = [
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
  "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
  "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
  "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
  "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
  ".", ",", "?", "!", "'", "\"", " ",
  "0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
]

question = QuestionSource.get_question "http://minisculus.edendevelopment.co.uk/start"

letters = question.text.chars.map do |char|
  position = keys.find_index char
  keys[position + 6]
end

answer = letters.join

req = Net::HTTP::Put.new(question.uri.path)
req.body = {"answer" => answer}.to_json
req["Content-Type"] = "application/json"
res = Net::HTTP.new(question.uri.host, question.uri.port).start {|http| http.request(req) }
puts res["location"]
