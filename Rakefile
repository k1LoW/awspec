require 'bundler/gem_tasks'
begin
  require 'rspec/core/rake_task'
  require 'octorelease'
rescue LoadError
end

if defined?(RSpec)
  task spec: 'spec:all'
  namespace :spec do
    task all: ['spec:type', 'spec:generator']

    RSpec::Core::RakeTask.new(:type) do |t|
      t.pattern = 'spec/type/*_spec.rb'
    end

    RSpec::Core::RakeTask.new(:generator) do |t|
      t.pattern = 'spec/generator/*_spec.rb'
    end
  end
end
