module Awspec::Generator
  module Spec
    class Subnet
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          subnet_id cidr_block
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        subnets = select_subnet_by_vpc_id(@vpc_id)
        specs = subnets.map do |subnet|
          subnet_id = subnet[:subnet_id]
          subnet_tag_name = subnet.tag_name
          content = ERB.new(subnet_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def subnet_spec_template
        template = <<-'EOF'
<%- if subnet_tag_name -%>
describe subnet('<%= subnet_tag_name %>') do
<%- else -%>
describe subnet('<%= subnet_id %>') do
<%- end -%>
  it { should exist }
  it { should be_<%= subnet.state %> }
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<% describes.each do |describe| %>
<%- if subnet.members.include?(describe.to_sym) && !subnet[describe.to_sym].nil? -%>
<%- if subnet[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= subnet[describe] %>' }
<%- else -%>
  its(:<%= describe %>) { should eq <%= subnet[describe] %> }
<%- end -%>
<%- end -%>
<% end %>
end
EOF
        template
      end
    end
  end
end
