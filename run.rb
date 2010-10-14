#!/usr/bin/env ruby

require "rubygems"
require "launchy"

$:.unshift File.expand_path("../lib", __FILE__)
require "question_source"
require "mark_1"
require "mark_2"
require "mark_4"
require "decoder"

def solve_question url, encoder
  question = QuestionSource.get_question url
  answer = encoder.encode question.question
  path_to_next_question = question.answer answer
  URI.parse(url).merge(path_to_next_question).to_s
rescue Question::WrongAnswer
  Launchy.open question.reference_url
  raise
end

def solve_questions
  encoders = [Mark1.new(6), Mark2.new(9, 3), Mark4.new(4, 7), Decoder.new(7, 2)]
  initial_url = "http://minisculus.edendevelopment.co.uk/start"
  encoders.inject initial_url do |url, encoder|
    solve_question url, encoder
  end
end

def try_decoding code, wheel_1_position, wheel_2_position
  clue_words = %w{FURLIN BUNKER}
  decoder = Decoder.new wheel_1_position, wheel_2_position
  decoded_text = decoder.encode code
  if clue_words.all? {|word| decoded_text =~ /#{word}/ }
    @original_text = decoded_text
    @successful_settings << [wheel_1_position, wheel_2_position]
  end
end

def solve_final_question url
  question = QuestionSource.get_question url
  code = question.code
  @email = question.email
  @successful_settings = []

  (0..9).each do |wheel_1_position|
    (0..9).each do |wheel_2_position|
      try_decoding code, wheel_1_position, wheel_2_position
    end
  end

  unless @original_text
    Launchy.open question.reference_url
    raise "No clue words found in decoded text"
  end
end

def report_results
  puts <<"EOF"

Original text:

#{@original_text}

Successful wheel settings:

#{@successful_settings.inspect}

Well done! Now send your results to #{@email}

EOF
end

# Here we go...

final_question_url = solve_questions
solve_final_question final_question_url
report_results
