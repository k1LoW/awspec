# frozen_string_literal: true

module Awspec::Type
  class Wafv2WebAcl < ResourceBase
    attr_accessor :scope

    def resource_via_client
      @resource_via_client ||= find_web_acl(scope, @display_name)
    end

    def id
      @id ||= resource_via_client.id if resource_via_client
    end

    def scope
      @scope || 'REGIONAL'
    end

    def default_action
      resource_via_client.default_action.allow ? 'ALLOW' : 'BLOCK'
    end

    def has_rule?(name, priority = nil, action = nil, override_action = nil)
      resource_via_client.rules.find do |rule|
        next false if !priority.nil? && rule.priority != priority
        next false if !action.nil? && !rule.action.reject { |v| v.nil? }.first.class.to_s.include?(action.capitalize)
        next false if !override_action.nil? &&
                      !rule.override_action.reject { |v| v.nil? }.first.class.to_s.include?(override_action.capitalize)
        next true if rule.name == name
      end
    end
  end
end
