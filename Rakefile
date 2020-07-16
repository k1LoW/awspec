require 'bundler/gem_tasks'

begin
  require 'rspec'
  require 'rspec/core'
  require 'rspec/core/rake_task'
  require 'octorelease'
  require 'rubocop/rake_task'
rescue LoadError
end

require 'awspec'

types = Awspec::Helper::Type::TYPES.map do |type|
  'spec:' + type
end

if defined?(RSpec)
  task spec: 'spec:all'
  namespace :spec do
    task all: ['spec:type',
               'spec:account',
               'spec:core',
               'spec:generator_spec',
               'spec:generator_doc',
               'spec:rubocop',
               'spec:helper']

    task type: types

    Awspec::Helper::Type::TYPES.map do |type|
      RSpec::Core::RakeTask.new(type) do |t|
        t.pattern = 'spec/type/' + type + '_spec.rb'
      end
    end

    RSpec::Core::RakeTask.new(:account) do |t|
      t.pattern = 'spec/type/account_spec.rb'
    end

    RSpec::Core::RakeTask.new(:core) do |t|
      t.pattern = 'spec/core/*_spec.rb'
    end

    RSpec::Core::RakeTask.new(:generator_spec) do |t|
      t.pattern = 'spec/generator/spec/*_spec.rb'
    end

    RSpec::Core::RakeTask.new(:generator_doc) do |t|
      t.pattern = 'spec/generator/doc/*_spec.rb'
    end

    RSpec::Core::RakeTask.new(:helper) do |t|
      t.pattern = 'spec/lib/awspec/helper/*_spec.rb'
    end

    RuboCop::RakeTask.new
  end
end

task :generate_docs do
  docs = Awspec::Generator::Doc::Type.generate_doc
  File.write('doc/resource_types.md', docs + "\n")
end
