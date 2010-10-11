require "rspec"
$:.unshift File.expand_path("../../lib", __FILE__)

require "webmock"
require "webmock/rspec"
include WebMock
