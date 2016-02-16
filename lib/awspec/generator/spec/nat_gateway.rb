module Awspec::Generator
  module Spec
    class NatGateway
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        nat_gateways = select_nat_gateway_by_vpc_id(@vpc_id)
        specs = nat_gateways.map do |nat_gateway|
          nat_gateway_id = nat_gateway[:nat_gateway_id]
          content = ERB.new(nat_gateway_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def nat_gateway_spec_template
        template = <<-'EOF'
describe nat_gateway('<%= nat_gateway_id %>') do
  it { should exist }
  it { should be_<%= nat_gateway.state %> }
<%- if @vpc_tag_name -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should belong_to_vpc('<%= @vpc_id %>') }
<%- end -%>
<% nat_gateway.nat_gateway_addresses.each do |address| %>
  it { should have_eip('<%= address.public_ip %>') }
<% end %>
end
EOF
        template
      end
    end
  end
end
