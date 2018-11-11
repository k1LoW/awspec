module Awspec::Generator
  module Spec
    class Ec2
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          instance_id image_id private_dns_name public_dns_name
          instance_type private_ip_address public_ip_address
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        instances = select_ec2_by_vpc_id(@vpc_id)
        specs = instances.map do |instance|
          instance_id = instance[:instance_id]
          instance_tag_name = instance.tag_name
          subnet = find_subnet(instance.subnet_id)
          eips = select_eip_by_instance_id(instance_id)
          volumes = select_ebs_by_instance_id(instance_id)
          network_interfaces = select_network_interface_by_instance_id(instance_id)
          credit_specification = find_ec2_credit_specifications(instance_id)
          content = ERB.new(ec2_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      # rubocop:disable all
      def ec2_spec_template
        template = <<-'EOF'
<%- if instance_tag_name -%>
describe ec2('<%= instance_tag_name %>') do
<%- else -%>
describe ec2('<%= instance_id %>') do
<%- end -%>
  it { should exist }
  it { should be_<%= instance.state.name %> }
<% describes.each do |describe| %>
<%- if instance.members.include?(describe.to_sym) && !instance[describe.to_sym].nil? -%>
<%- if instance[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= instance[describe] %>' }
<%- else -%>
  its(:<%= describe %>) { should eq <%= instance[describe] %> }
<%- end -%>
<%- end -%>
<% end %>
<% instance.security_groups.each do |sg| %>
  it { should have_security_group('<%= sg.group_name %>') }
<% end %>
<%- if @vpc_tag_name -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should belong_to_vpc('<%= @vpc_id %>') }
<%- end -%>
<%- if subnet.tag_name -%>
  it { should belong_to_subnet('<%= subnet.tag_name %>') }
<%- else -%>
  it { should belong_to_subnet('<%= subnet.subnet_id %>') }
<%- end -%>
<% eips.each do |eip| %>
  it { should have_eip('<%= eip.public_ip %>') }
<% end %>
<% volumes.each do |volume| %>
<%- if volume.tag_name -%>
  it { should have_ebs('<%= volume.tag_name %>') }
<%- else -%>
  it { should have_ebs('<%= volume.volume_id %>') }
<%- end -%>
<% end %>
<% network_interfaces.each do |interface| %>
  it { should have_network_interface('<%= interface.network_interface_id %>') }
<% end %>
<%- if credit_specification.cpu_credits -%>
  it { should have_credit_specification('<%= credit_specification.cpu_credits %>') }
<%- end -%>
end
EOF
        template
      end
    end
  end
end
