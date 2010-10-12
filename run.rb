#!/usr/bin/env ruby

require "rubygems"
require "launchy"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "mark_1"
require "mark_2"
require "mark_4"

def solve_challenge url, encoder
  question = QuestionSource.get_question url
  answer = encoder.encode question.text
  path_to_next_question = question.answer answer
  URI.parse(url).merge(path_to_next_question).to_s
rescue Question::WrongAnswer
  Launchy.open question.reference_url
  raise
end

encoders = [
  Mark1.new(6),
  Mark2.new(9, 3),
  Mark4.new(4, 7)
]
initial_url = "http://minisculus.edendevelopment.co.uk/start"

encoders.inject initial_url do |url, encoder|
  solve_challenge url, encoder
end
