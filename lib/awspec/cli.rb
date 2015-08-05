require 'thor'
require 'awspec/setup'

module Awspec
  class CLI < Thor
    desc 'awspec init', 'Generate init files'
    def init
      Awspec::Setup.run
    end

    desc 'awspec generate [vpc_id]', 'Generate *_spec.rb from VPC ID (or VPC "Name" tag)'
    def generate(vpc_id)
      Awspec::Setup.generate_from_vpc(vpc_id)
    end

    map 'g' => 'generate'
  end
end
