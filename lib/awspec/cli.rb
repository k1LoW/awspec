require 'thor'
require 'awspec/setup'
require 'awspec/command/generate'

module Awspec
  class CLI < Thor
    desc 'init', 'Generate init files'
    def init
      Awspec::Setup.run
    end

    desc 'generate [resource]', 'Generate AWS resource *_spec.rb'
    subcommand 'generate', Generate
    map 'g' => 'generate'

    option :version, type: :boolean, aliases: :v
    def help(version = nil)
      if version
        puts Awspec::VERSION
      else
        super
      end
    end
  end
end
