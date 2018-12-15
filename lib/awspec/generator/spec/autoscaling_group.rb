module Awspec::Generator
  module Spec
    class AutoscalingGroup
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          auto_scaling_group_name auto_scaling_group_arn min_size max_size desired_capacity
          default_cooldown availability_zones health_check_type health_check_grace_period
          vpc_zone_identifier termination_policies new_instances_protected_from_scale_in
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        autoscaling_groups = select_autoscaling_group_by_vpc_id(@vpc_id)
        specs = autoscaling_groups.map do |autoscaling_group|
          content = ERB.new(autoscaling_group_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def autoscaling_group_spec_template
        template = <<-'EOF'
describe autoscaling_group('<%= autoscaling_group.auto_scaling_group_name %>') do
  it { should exist }
<% describes.each do |describe| %>
<%- if autoscaling_group.members.include?(describe.to_sym) && !autoscaling_group[describe.to_sym].nil? -%>
<%- if autoscaling_group[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= autoscaling_group[describe] %>' }
<%- else -%>
  its(:<%= describe %>) { should eq <%= autoscaling_group[describe] %> }
<%- end -%>
<%- end -%>
<% end %>
<%- unless autoscaling_group.launch_configuration_name.nil? -%>
  it { should have_launch_configuration('<%= autoscaling_group.launch_configuration_name %>') }
<%- else -%>
  its('launch_template.launch_template_name') { should eq '<%= autoscaling_group.launch_template.launch_template_name %>' }
<%- end -%>
<% autoscaling_group[:load_balancer_names].each do |desc| %>
  it { should have_elb('<%= desc %>') }
<% end %>
<% autoscaling_group[:target_group_arns].join(",").gsub(/arn:.+?:targetgroup\/(.[^\/]*)\/.[^,]*/, '\1').split(",").each do |desc| %>
  <%- if not find_alb_target_group(desc).nil? -%>
  it { should have_alb_target_group('<%= desc %>') }
  <%- elsif not find_nlb_target_group(desc).nil? -%>
  it { should have_nlb_target_group('<%= desc %>') }
  <%- end -%>
<% end %>
end
EOF
        template
      end
    end
  end
end
