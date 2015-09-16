require 'aws-sdk'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    attr_reader :id, :resource

    def initialize(id = nil)
      @display_name = id
      super
      @id = nil
    end

    def to_s
      type = self.class.name.demodulize.underscore
      "#{type} '#{@display_name}'"
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
