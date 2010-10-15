#!/usr/bin/env ruby

require "rubygems"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "mark_4"

print "Enter plain text: "
code = gets.chomp

print "Enter wheel 1 setting: "
wheel_1_position = gets.to_i

print "Enter wheel 2 setting: "
wheel_2_position = gets.to_i

encoder = Mark4.new wheel_1_position, wheel_2_position
puts encoder.encode(code)
