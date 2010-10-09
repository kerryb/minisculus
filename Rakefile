require "bundler"
Bundler.setup

require "rspec/core/rake_task"

task :default => [:spec, :check_coverage]

RSpec::Core::RakeTask.new("spec") do |t|
  t.pattern = FileList["spec/**/*_spec.rb"]
  t.rcov = true
  t.rcov_opts = "--exclude spec,$GEM_HOME"
end

task :check_coverage do
  total_coverage = 0
  if File.exists?('coverage')
    File.open('coverage/index.html').each_line do |line|
      if line =~ /<tt class='coverage_total'>\s*(\d+\.\d+)%\s*<\/tt>/
        total_coverage = $1.to_f
        break
      end
    end
    puts "Coverage: #{total_coverage}%"
    raise "Coverage must be at least 100% but was #{total_coverage}%" if total_coverage < 100
  end
end
