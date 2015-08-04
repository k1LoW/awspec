module Awspec::Generator
  class Ec2
    include Awspec::Helper::Finder
    def generate_from_vpc(vpc_id)
      describes = %w(
        instance_id image_id private_dns_name public_dns_name
        instance_type private_ip_address public_ip_address
      )
      vpc = find_vpc(vpc_id)
      fail 'Not Found VPC' unless vpc
      @vpc_id = vpc[:vpc_id]
      @vpc_tag_name = vpc.tag_name
      instances = select_ec2_by_vpc_id(@vpc_id)
      specs = instances.map do |instance|
        instance_id = instance[:instance_id]
        instance_tag_name = instance.tag_name
        subnet = find_subnet(instance.subnet_id)
        subnet_tag_name = subnet.tag_name
        eips = select_eip_by_instance_id(instance_id)
        content = ERB.new(ec2_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end
      specs.join("\n")
    end

    def ec2_spec_template
      template = <<-'EOF'
describe ec2('<%= instance_tag_name %>') do
  it { should exist }
  it { should be_<%= instance.state.name %> }
<% describes.each do |describe| %>
<%- if instance.key?(describe) -%>
  its(:<%= describe %>) { should eq '<%= instance[describe] %>' }
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
  it { should belong_to_subnet('<%= subnet_tag_name %>') }
<% eips.each do |eip| %>
  it { should have_eip('<%= eip.public_ip %>') }
<% end %>
end
EOF
      template
    end
  end
end
