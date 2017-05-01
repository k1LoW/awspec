module Awspec::Generator
  module Spec
    class Eip
      include Awspec::Helper::Finder
      def select_all_addresses
        res = ec2_client.describe_addresses
        res.addresses
      end

      def generate_all
        eips = select_all_addresses
        raise 'Not Found Elastic IP addresses.' if eips.empty?
        ERB.new(eip_spec_template, nil, '-').result(binding).chomp
      end

      def eip_spec_template
        template = <<-'EOF'
<% eips.each do |eip| %>
describe eip('<%= eip.public_ip %>') do
  it { should exist }
  it { should be_associated_to('<%= eip.instance_id %>') }
  it { should belong_to_domain('<%= eip.domain %>') }
end
<% end %>
EOF
        template
      end
    end
  end
end
