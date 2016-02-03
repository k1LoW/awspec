module Awspec::Generator
  module Spec
    class NetworkAcl
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
        )
        vpc = find_vpc(vpc_id)
        fail 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        network_acls = select_network_acl_by_vpc_id(@vpc_id)
        specs = network_acls.map do |acl|
          linespecs = generate_linespecs(acl)
          subnet_specs = generate_subnet_specs(acl)
          network_acl_id = acl[:network_acl_id]
          network_acl_tag_name = acl.tag_name
          inbound_entries_count = acl.entries.count do |entry|
            entry.egress == false
          end
          outbound_entries_count = acl.entries.count do |entry|
            entry.egress == true
          end
          content = ERB.new(network_acl_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_subnet_specs(acl)
        specs = []
        acl.associations.each do |a|
          subnet = find_subnet(a.subnet_id)
          spec = if subnet.tag_name
                   "it { should have_subnet('" + subnet.tag_name + "') }"
                 else
                   "it { should have_subnet('" + subnet.subnet_id + "') }"
                 end
          specs.push(spec)
        end
        specs
      end

      def generate_linespecs(acl)
        linespecs = []
        protocols = Awspec::Type::NetworkAcl::PROTOCOLS.invert
        acl.entries.each do |entry|
          line = ''
          inout = 'inbound'
          inout = 'outbound' if entry.egress
          line += 'its(:' + inout + ') { should'
          actions = { allow: 'be_allowed', deny: 'be_denied' }
          line += ' ' + actions[entry.rule_action.to_sym]
          port_range = entry.port_range
          unless port_range.nil?
            port = if port_range.from == port_range.to
                     port_range.from.to_s
                   else
                     "'" + port_range.from.to_s + '-' + port_range.to.to_s + "'"
                   end
            line += '(' + port + ')'
          end
          line += ".protocol('" + protocols[entry.protocol.to_i] + "')"
          line += ".source('" + entry.cidr_block + "')"
          rule_number = entry.rule_number.to_i
          rule_number = "'*'" if rule_number == 32_767
          line += '.rule_number(' + rule_number.to_s + ')'
          line += ' }'
          linespecs.push(line)
        end
        linespecs
      end

      def network_acl_spec_template
        template = <<-'EOF'
<%- if network_acl_tag_name -%>
describe network_acl('<%= network_acl_tag_name %>') do
<%- else -%>
describe network_acl('<%= network_acl_id %>') do
<%- end -%>
  it { should exist }
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<% subnet_specs.each do |spec| %>
  <%= spec %>
<% end %>
<% linespecs.each do |line| %>
  <%= line %>
<% end %>
  its(:inbound_entries_count) { should eq <%= inbound_entries_count %> }
  its(:outbound_entries_count) { should eq <%= inbound_entries_count %> }
end
EOF
        template
      end
    end
  end
end
