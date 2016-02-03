module Awspec::Generator
  module Spec
    class Elb
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          load_balancer_name
        )
        health_check_options = %w(
          target interval timeout
          unhealthy_threshold healthy_threshold
        )
        vpc = find_vpc(vpc_id)
        fail 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        lbs = select_elb_by_vpc_id(@vpc_id)

        specs = lbs.map do |lb|
          content = ERB.new(elb_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def elb_spec_template
        template = <<-'EOF'
describe elb('<%= lb.load_balancer_name %>') do
  it { should exist }
<% describes.each do |describe| %>
<%- if lb.members.include?(describe.to_sym) && !lb[describe.to_sym].nil? -%>
<%- if lb[describe].is_a?(TrueClass) || lb[describe].is_a?(FalseClass) -%>
  its(:<%= describe %>) { should eq <%= lb[describe] %> }
<%- else -%>
  its(:<%= describe %>) { should eq '<%= lb[describe] %>' }
<%- end -%>
<%- end -%>
<% end %>
<% health_check_options.each do |option| %>
<%- if lb[:health_check].members.include?(option.to_sym) && !lb[:health_check][option].nil? -%>
<%- if lb[:health_check][option].is_a?(String) -%>
  its(:health_check_<%= option %>) { should eq '<%= lb[:health_check][option] %>' }
<%- else -%>
  its(:health_check_<%= option %>) { should eq <%= lb[:health_check][option] %> }
<%- end -%>
<%- end -%>
<% end %>
<% lb[:listener_descriptions].each do |desc| %>
  it { should have_listener(protocol: '<%= desc.listener.protocol %>', port: <%= desc.listener.load_balancer_port %>, instance_protocol: '<%= desc.listener.instance_protocol %>', instance_port: <%= desc.listener.instance_port %>) }
<% end %>
end
EOF
        template
      end
    end
  end
end
