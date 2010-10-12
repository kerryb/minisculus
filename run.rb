#!/usr/bin/env ruby

require "rubygems"
require "launchy"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "mark_1"
require "mark_2"

begin
  question = QuestionSource.get_question "http://minisculus.edendevelopment.co.uk/start"
  answer = Mark1.new(6).encode question.text
  path_to_next_question = question.answer answer
  question = QuestionSource.get_question(
    "http://minisculus.edendevelopment.co.uk#{path_to_next_question}")
  answer = Mark2.new(9, 3).encode question.text
  path_to_next_question = question.answer answer
rescue Question::WrongAnswer
  Launchy.open question.reference_url
  raise
end

