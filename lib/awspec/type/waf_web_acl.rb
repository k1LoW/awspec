module Awspec::Type
  class WafWebAcl < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_waf_web_acl(@display_name)
    end

    def id
      @id ||= resource_via_client.web_acl_id if resource_via_client
    end

    def default_action
      resource_via_client.default_action.type
    end

    def has_rule?(rule_id, priority = nil, action = nil)
      resource_via_client.rules.find do |rule|
        next false if !priority.nil? && rule.priority != priority
        next false if !action.nil? && rule.action.type != action
        next true if rule.rule_id == rule_id
        find_waf_rule(rule_id).name == rule_id
      end
    end
  end
end
