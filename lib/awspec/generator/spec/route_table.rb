require 'pp'

module Awspec::Generator
  module Spec
    class RouteTable
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
        )
        vpc = find_vpc(vpc_id)
        fail 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        route_tables = select_route_table_by_vpc_id(@vpc_id)
        specs = route_tables.map do |route_table|
          linespecs = generate_linespecs(route_table)
          route_table_id = route_table[:route_table_id]
          route_table_tag_name = route_table.tag_name
          content = ERB.new(route_table_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_linespecs(route_table)
        linespecs = []
        route_table.routes.each do |route|
          linespecs.push(ERB.new(route_table_spec_linetemplate, nil, '-').result(binding))
        end
        linespecs
      end

      def route_table_spec_linetemplate
        template = <<-'EOF'
it { shold have_route('<%= route.gateway_id %>').destination('<%= route.destination_cidr_block %>') }
EOF
        template
      end

      def route_table_spec_template
        template = <<-'EOF'
<%- if route_table_tag_name -%>
describe route_table('<%= route_table_tag_name %>') do
<%- else -%>
describe route_table('<%= route_table_id %>') do
<%- end -%>
  it { should exist }
<%- if @vpc_tag_name -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should belong_to_vpc('<%= @vpc_id %>') }
<%- end -%>
<% linespecs.each do |line| %>
  <%= line %>
<% end %>
end
EOF
        template
      end
    end
  end
end
