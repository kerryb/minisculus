require "bundler"
Bundler.setup

require "rspec/core/rake_task"

task :default => :spec

RSpec::Core::RakeTask.new("spec") do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
end
