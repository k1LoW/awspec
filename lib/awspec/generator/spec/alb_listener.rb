module Awspec::Generator
  module Spec
    class AlbListener
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          load_balancer_arn port protocol ssl_policy
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        albs = select_alb_by_vpc_id(@vpc_id)

        specs = albs.map do |alb|
          alb_listeners = select_alb_listener_by_alb_arn(alb.load_balancer_arn)
          alb_listeners.map do |listener|
            rules = select_rule_by_alb_listener_id(listener.listener_arn).map(&:to_h)
            rules.map do |rule|
              content = ERB.new(alb_listener_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
            end
          end
        end
        specs.join("\n")
      end

      def generate_rule_conditions_specs(conditions)
        conditions_lines = []
        conditions.each do |condition|
          conditions_lines.push("{field: '#{condition[:field]}', values: #{condition[:values]}}")
        end
        conditions_lines.join(', ')
      end

      def generate_action_configs_specs(config)
        action_config = []
        config.each do |key, value|
          if value.is_a?(String)
            action_config.push("#{key}: '#{value}'")
          elsif value.is_a?(Hash)
            value.each do |vkey, vvalue|
              if vvalue.is_a?(String)
                action_config.push("#{key}: {#{vkey}: '#{vvalue}'}")
              else
                action_config.push("#{key}: {#{vkey}: #{vvalue}}")
              end
            end
          else
            action_config.push("#{key}: #{value}")
          end
        end
        action_config
      end

      def generate_rule_actions_specs(actions)
        actions_line = []
        actions.each do |action|
          action_line = []
          action_line.push("type: '#{action[:type]}'")
          action_line.push("order: #{action[:order]}") unless action[:order].nil?
          action_line.push("target_group_arn: '#{action[:target_group_arn]}'") unless action[:target_group_arn].nil?
          unless action[:redirect_config].nil?
            redirect_config = generate_action_configs_specs(action[:redirect_config])
            action_line.push("redirect_config: {#{redirect_config.join(', ')}}")
          end
          unless action[:fixed_response_config].nil?
            fixed_response_config = generate_action_configs_specs(action[:fixed_response_config])
            action_line.push("fixed_response_config: {#{fixed_response_config.join(', ')}}")
          end
          unless action[:authenticate_oidc_config].nil?
            authenticate_oidc_config = generate_action_configs_specs(action[:authenticate_oidc_config])
            action_line.push("authenticate_oidc_config: {#{authenticate_oidc_config.join(', ')}}")
          end
          actions_line.push("{#{action_line.join(', ')}}")
        end
        actions_line.join(', ')
      end

      def alb_listener_spec_template
        template = <<-'EOF'
describe alb_listener('<%= listener.listener_arn %>') do
  it { should exist }
  <%- describes.each do |describe| -%>
  <%- if listener.key?(describe) -%>
  <%- if listener[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= listener[describe] %>' }
  <%- else -%>
  its(:<%= describe %>) { should eq <%= listener[describe] %> }
  <%- end -%>
  <%- end -%>
  <%- end -%>
  <%- rules.each do |rule| -%>
  it { should have_rule('<%= rule[:rule_arn] %>') }
  it do
    should have_rule.priority('<%= rule[:priority] %>')
    <%- unless rule[:conditions].empty? -%>
      .conditions([<%= generate_rule_conditions_specs(rule[:conditions]) %>])
    <%- end -%>
  <%- unless rule[:actions].empty? -%>
      .actions([<%= generate_rule_actions_specs(rule[:actions]) %>])
  <%- end -%>
  end
  <%- end -%>
end
EOF
        template
      end
    end
  end
end
