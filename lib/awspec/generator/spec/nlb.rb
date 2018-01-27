module Awspec::Generator
  module Spec
    class Nlb
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          load_balancer_name
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        nlbs = select_nlb_by_vpc_id(@vpc_id)

        specs = nlbs.map do |nlb|
          content = ERB.new(nlb_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def nlb_spec_template
        template = <<-'EOF'
describe nlb('<%= nlb.load_balancer_name %>') do
  it { should exist }
  its(:load_balancer_arn) { should eq '<%= nlb.load_balancer_arn %>' }
  its(:dns_name) { should eq '<%= nlb.dns_name %>' }
  its(:load_balancer_name) { should eq '<%= nlb.load_balancer_name %>' }
  its(:scheme) { should eq '<%= nlb.scheme %>' }
  its(:vpc_id) { should eq '<%= nlb.vpc_id %>' }
  its(:type) { should eq '<%= nlb.type %>' }
  its(:ip_address_type) { should eq '<%= nlb.ip_address_type %>' }
end
EOF
        template
      end
    end
  end
end
