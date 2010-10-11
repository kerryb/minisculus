#!/usr/bin/env ruby

require "rubygems"
require "net/http"
require "json"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "mark_1"

question = QuestionSource.get_question "http://minisculus.edendevelopment.co.uk/start"
answer = Mark1.new(6).encode question.text

puts question.answer answer
