module Awspec::Generator
  module Spec
    class Vpc
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          vpc_id cidr_block
        )
        vpc = find_vpc(vpc_id)
        fail 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        route_tables = select_route_table_by_vpc_id(@vpc_id)
        network_acls = select_network_acl_by_vpc_id(@vpc_id)
        spec = ERB.new(vpc_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      # rubocop:disable all
      def vpc_spec_template
        template = <<-'EOF'
<%- if @vpc_tag_name -%>
describe vpc('<%= @vpc_tag_name %>') do
<%- else -%>
describe vpc('<%= @vpc_id %>') do
<%- end -%>
  it { should exist }
  it { should be_<%= vpc.state %> }
<% describes.each do |describe| %>
<%- if vpc.key?(describe) -%>
<%- if vpc[describe].is_a?(TrueClass) || vpc[describe].is_a?(FalseClass) -%>
  its(:<%= describe %>) { should eq <%= vpc[describe] %> }
<%- else -%>
  its(:<%= describe %>) { should eq '<%= vpc[describe] %>' }
<%- end -%>
<%- end -%>
<% end %>
<% route_tables.each do |route_table| %>
<%- if route_table.tag_name -%>
  it { should have_route_table('<%= route_table.tag_name %>') }
<%- else -%>
  it { should have_route_table('<%= route_table.route_table_id %>') }
<%- end -%>
<% end %>
<% network_acls.each do |network_acl| %>
<%- if network_acl.tag_name -%>
  it { should have_network_acl('<%= network_acl.tag_name %>') }
<%- else -%>
  it { should have_network_acl('<%= network_acl.network_acl_id %>') }
<%- end -%>
<% end %>
end
EOF
        template
      end
    end
  end
end
