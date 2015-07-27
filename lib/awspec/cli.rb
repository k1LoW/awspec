require 'thor'
require 'awspec/setup'

module Awspec
  class CLI < Thor
    desc 'awspec init', 'Generate awspec spec_helper.rb'
    def init
      Awspec::Setup.run
    end
  end
end
