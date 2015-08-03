require 'aws-sdk'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    attr_reader :id

    def initialize(id = nil)
      super
      @id = nil
    end

    def exists?
      @id
    end
  end
end
