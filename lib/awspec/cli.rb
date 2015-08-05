require 'thor'
require 'awspec/setup'
require 'awspec/command/generate'

module Awspec
  class CLI < Thor
    desc 'awspec init', 'Generate init files'
    def init
      Awspec::Setup.run
    end

    desc 'awspec generate [vpc_id]', 'Generate *_spec.rb from VPC ID (or VPC "Name" tag)'
    subcommand 'generate', Generate
    map 'g' => 'generate'
  end
end
