module Awspec::Generator
  module Spec
    class Alb
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          load_balancer_name
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        albs = select_alb_by_vpc_id(@vpc_id)

        specs = albs.map do |alb|
          content = ERB.new(alb_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def alb_spec_template
        template = <<-'EOF'
describe alb('<%= alb.load_balancer_name %>') do
  it { should exist }
  its(:load_balancer_arn) { should eq '<%= alb.load_balancer_arn %>' }
  its(:dns_name) { should eq '<%= alb.dns_name %>' }
  its(:load_balancer_name) { should eq '<%= alb.load_balancer_name %>' }
  its(:scheme) { should eq '<%= alb.scheme %>' }
  its(:vpc_id) { should eq '<%= alb.vpc_id %>' }
  its(:type) { should eq '<%= alb.type %>' }
  its(:ip_address_type) { should eq '<%= alb.ip_address_type %>' }
end
EOF
        template
      end
    end
  end
end
