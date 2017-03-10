require 'aws-sdk'
require 'awspec/resource_reader'
require 'awspec/helper/finder'

module Awspec::Type
  class Base
    include Awspec::Helper::Finder
    include Awspec::BlackListForwardable
    attr_accessor :account

    def resource_via_client
      raise 'this method must be override!'
    end

    def to_s
      type = self.class.name.demodulize.underscore
      "#{type} '#{@display_name}'"
    end

    def inspect
      to_s
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
      name_str = name.to_s if name.class == Symbol
      describe = name_str.tr('-', '_').to_sym
      if !resource_via_client.nil? && resource_via_client.members.include?(describe)
        resource_via_client[describe]
      else
        super unless self.respond_to?(:resource)
        method_missing_via_black_list(name, delegate_to: resource)
      end
    end
  end
end
