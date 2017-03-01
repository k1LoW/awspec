require 'aws-sdk'
require 'awspec/resource_reader'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    include Awspec::BlackListForwardable

    def to_s
      type = self.class.name.demodulize.underscore
      "#{type} '#{@display_name}'"
    end

    def inspect
      to_s
    end

    def resource_via_client
      raise 'this method must be override!'
    end

    def self.tags_allowed
      define_method :has_tag? do |key, value|
        begin
          tags = resource_via_client.tags
        rescue NoMethodError
          tags = resource_via_client.tag_set
        end
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
