require 'aws-sdk'
require 'awspec/resource_reader'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    include Awspec::BlackListForwardable

    attr_reader :id, :resource_via_client

    def initialize(display_name = nil)
      @display_name = display_name
      @id = nil
    end

    def to_s
      type = self.class.name.demodulize.underscore
      "#{type} '#{@display_name}'"
    end

    def inspect
      to_s
    end

    def exists?
      id
    end

    def id
      raise 'this method must be override!'
    end

    def resource_via_client
      raise 'this method must be override!'
    end

    def self.aws_resource(resource)
      define_method :resource do
        @resource ||= Awspec::ResourceReader.new(resource.new(id))
      end
    end

    def self.tags_allowed
      define_method :has_tag? do |key, value|
        tags = resource_via_client.tags
        return false unless tags
        tags.any? { |t| t['key'] == key && t['value'] == value }
      end
    end

    def method_missing(name)
      describe = name.to_sym
      if resource_via_client.members.include?(describe)
        resource_via_client[describe]
      else
        super unless self.respond_to?(:resource)
        method_missing_via_black_list(name, delegate_to: resource)
      end
    end
  end
end
