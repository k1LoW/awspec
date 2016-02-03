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
          linespecs = generate_route_linespecs(route_table)
          subnet_linespecs = generate_subnet_linespecs(route_table)
          route_table_id = route_table[:route_table_id]
          route_table_tag_name = route_table.tag_name
          content = ERB.new(route_table_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_route_linespecs(route_table)
        linespecs = []
        route_table.routes.each do |route|
          linespecs.push(ERB.new(route_table_spec_gateway_linetemplate, nil, '-').result(binding)) if route.gateway_id
          if route.instance_id
            instance = find_ec2(route.instance_id)
            linespecs.push(ERB.new(route_table_spec_instance_linetemplate, nil, '-').result(binding)) if instance
          end
          if route.vpc_peering_connection_id
            connection = find_vpc_peering_connection(route.vpc_peering_connection_id)
            linespecs.push(ERB.new(route_table_spec_connection_linetemplate, nil, '-').result(binding)) if connection
          end
          if route.nat_gateway_id
            linespecs.push(ERB.new(route_table_spec_nat_linetemplate, nil, '-').result(binding))
          end
        end
        linespecs
      end

      def generate_subnet_linespecs(route_table)
        linespecs = []
        route_table.associations.each do |a|
          next if a.subnet_id.nil?
          subnet = find_subnet(a.subnet_id)
          linespecs.push(ERB.new(route_table_spec_subnet_linetemplate, nil, '-').result(binding)) if subnet
        end
        linespecs
      end

      def route_table_spec_gateway_linetemplate
        template = <<-'EOF'
it { should have_route('<%= route.destination_cidr_block %>').target(gateway: '<%= route.gateway_id %>') }
EOF
        template
      end

      def route_table_spec_instance_linetemplate
        template = <<-'EOF'
<%- if instance.tag_name -%>
it { should have_route('<%= route.destination_cidr_block %>').target(instance: '<%= instance.tag_name %>') }
<%- else -%>
it { should have_route('<%= route.destination_cidr_block %>').target(instance: '<%= route.instance_id %>') }
<%- end -%>
EOF
        template
      end

      def route_table_spec_connection_linetemplate
        template = <<-'EOF'
<%- if connection.tag_name -%>
it { should have_route('<%= route.destination_cidr_block %>').target(vpc_peering_connection: '<%= connection.tag_name %>') }
<%- else -%>
it { should have_route('<%= route.destination_cidr_block %>').target(vpc_peering_connection: '<%= route.vpc_peering_connection_id %>') }
<%- end -%>
EOF
        template
      end

      def route_table_spec_nat_linetemplate
        template = <<-'EOF'
it { should have_route('<%= route.destination_cidr_block %>').target(nat: '<%= route.nat_gateway_id %>') }
EOF
        template
      end

      def route_table_spec_subnet_linetemplate
        template = <<-'EOF'
<%- if subnet.tag_name -%>
it { should have_subnet('<%= subnet.tag_name %>') }
<%- else -%>
it { should have_subnet('<%= subnet.subnet_id %>') }
<%- end -%>
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
<% subnet_linespecs.each do |line| %>
  <%= line %>
<% end %>
end
EOF
        template
      end
    end
  end
end
