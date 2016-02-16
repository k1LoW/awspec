module Awspec::Generator
  module Spec
    class Directconnect
      include Awspec::Helper::Finder
      def generate_all
        generate_virtual_interface_all
      end

      def generate_virtual_interface_all
        virtual_interfaces = select_virtual_interfaces
        raise 'Not Found virtual_interfaces' if virtual_interfaces.empty?
        ERB.new(virtual_interface_spec_template, nil, '-').result(binding).chomp
      end

      def virtual_interface_spec_template
        template = <<-'EOF'
<% virtual_interfaces.each do |interface| %>
describe directconnect_virtual_interface('<%= interface.virtual_interface_name %>') do
  it { should exist }
  it { should be_<%= interface.virtual_interface_state %> }
  its(:connection_id) { should eq '<%= interface.connection_id %>' }
  its(:virtual_interface_id) { should eq '<%= interface.virtual_interface_id %>' }
  its(:amazon_address) { should eq '<%= interface.amazon_address %>' }
  its(:customer_address) { should eq '<%= interface.customer_address %>' }
  its(:virtual_gateway_id) { should eq '<%= interface.virtual_gateway_id %>' }
end
<% end %>
EOF
        template
      end
    end
  end
end
