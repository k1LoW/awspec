module Awspec::Type
  class NlbListener < ResourceBase
    def resource_via_client
      @resource_via_client ||= find_nlb_listener(@display_name)
    end

    def id
      @id ||= resource_via_client.listener_arn if resource_via_client
    end

    def has_rule?(rule_id = nil, priority = nil, conditions = nil, actions = nil)
      rules = select_rule_by_nlb_listener_id(id)
      ret = rules.select do |rule|
        conditions = [conditions] if conditions.is_a?(Hash)
        actions = [actions] if actions.is_a?(Hash)
        next false if !rule_id.nil? && rule.rule_arn != rule_id
        next false if !priority.nil? && rule.priority != priority
        next false if !conditions.nil? && rule.conditions.map(&:to_h).sort_by(&:to_s) != conditions.sort_by(&:to_s)
        unless actions.nil?
          actions = actions.map do |action|
            if action.key?(:target_group_name)
              target_group = find_nlb_target_group(action[:target_group_name])
              action[:target_group_arn] = target_group.target_group_arn
              action.delete(:target_group_name)
            end
            action
          end
          next false if rule.actions.map(&:to_h).sort_by(&:to_s) != actions.sort_by(&:to_s)
        end
        true
      end
      ret.single_resource("rule_id = #{rule_id}, priority = #{priority}, \
conditions = #{conditions}, actions = #{actions}")
    end
  end
end
