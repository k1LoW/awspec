require 'thor'
require 'awspec/setup'
require 'awspec/command/generate'

module Awspec
  class CLI < Thor
    desc 'init', 'Generate init files'
    def init
      Awspec::Setup.run
    end

    desc 'generate [resource] [vpc_id]', 'Generate *_spec.rb from VPC ID'
    subcommand 'generate', Generate
    map 'g' => 'generate'
  end
end
