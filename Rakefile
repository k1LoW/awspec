require 'bundler/gem_tasks'
begin
  require 'rspec/core/rake_task'
  require 'octorelease'
rescue LoadError
end

if defined?(RSpec)
  task spec: 'spec:all'
  namespace :spec do
    task all: ['spec:type', 'spec:generator_spec']

    RSpec::Core::RakeTask.new(:type) do |t|
      t.pattern = 'spec/type/*_spec.rb'
    end

    RSpec::Core::RakeTask.new(:generator_spec) do |t|
      t.pattern = 'spec/generator/spec/*_spec.rb'
    end
  end
end
