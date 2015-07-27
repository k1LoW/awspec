require 'bundler/gem_tasks'
begin
  require 'rspec/core/rake_task'
rescue LoadError
end

if defined?(RSpec)
  task spec: 'spec:all'
  namespace :spec do
    task all: ['spec:type']

    RSpec::Core::RakeTask.new(:type) do |t|
      t.pattern = 'spec/type/*_spec.rb'
    end
  end
end
