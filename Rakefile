require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

rule '.rb' => '.y' do |t|
  sh "racc -l -o #{t.name} #{t.source}"
end

task compile: 'lib/mf_formula/parser.rb'
