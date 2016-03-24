module Awspec::Generator
  module Spec
    class NetworkInterface
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        network_interfaces = select_network_interface_by_vpc_id(@vpc_id)
        specs = network_interfaces.map do |interface|
          instance_spec = generate_instance_spec(interface)
          subnet_spec = generate_subnet_spec(interface)
          network_interface_id = interface[:network_interface_id]
          linespecs = generate_linespecs(interface)
          private_ip_addresses_count = interface.private_ip_addresses.count
          content = ERB.new(network_interface_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def generate_instance_spec(interface)
        return unless interface.attachment.instance_id
        instance = find_ec2(interface.attachment.instance_id)
        instance_spec = if instance.tag_name
                          "it { should be_attached_to('#{instance.tag_name}')"
                        else
                          "it { should be_attached_to('#{instance.instance_id}')"
                        end
        instance_spec += ".as_eth#{interface.attachment.device_index} }"
        instance_spec
      end

      def generate_subnet_spec(interface)
        return unless interface.subnet_id
        subnet = find_subnet(interface.subnet_id)
        subnet_spec = if subnet.tag_name
                        "it { should belong_to_subnet('#{subnet.tag_name}') }"
                      else
                        "it { should belong_to_subnet('#{subnet.subnet_id}') }"
                      end
        subnet_spec
      end

      def generate_linespecs(interface)
        linespecs = []
        interface.private_ip_addresses.each do |ip_address|
          line = "it { should have_private_ip_address('#{ip_address.private_ip_address}')"
          line += '.primary' if ip_address.primary
          line += ' }'
          linespecs.push(line)
        end
        linespecs
      end

      def network_interface_spec_template
        template = <<-'EOF'
describe network_interface('<%= network_interface_id %>') do
  it { should exist }
  it { should be_<%= interface.status.tr('-', '_') %> }
<%- if instance_spec -%>
  <%= instance_spec %>
<%- end -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- if subnet_spec -%>
  <%= subnet_spec %>
<%- end -%>
<% linespecs.each do |line| %>
  <%= line %>
<% end %>
  its(:private_ip_addresses_count) { should eq <%= interface.private_ip_addresses.count %> }
end
EOF
        template
      end
    end
  end
end
