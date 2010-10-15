#!/usr/bin/env ruby

require "rubygems"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "decoder"

print "Enter encoded text: "
code = gets.chomp

possibilities = []
(0..9).each do |wheel_1_position|
  (0..9).each do |wheel_2_position|
    decoder = Decoder.new wheel_1_position, wheel_2_position
    possibilities << decoder.encode(code)
  end
end

text = possibilities.inject " " do |memo, str|
  str.count(" ") > memo.count(" ") ? str : memo
end

puts text
