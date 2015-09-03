require 'aws-sdk'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    attr_reader :id, :resource

    def initialize(id = nil)
      super
      @id = nil
    end

    def exists?
      @id
    end

    def method_missing(name)
      describe = name.to_sym
      if @resource.members.include?(describe)
        @resource[describe]
      else
        super
      end
    end
  end
end
