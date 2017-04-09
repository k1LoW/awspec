module Awspec::Generator
  module Spec
    class InternetGateway
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        internet_gateways = select_internet_gateway_by_vpc_id(@vpc_id)
        specs = internet_gateways.map do |internet_gateway|
          internet_gateway_id = internet_gateway[:internet_gateway_id]
          content = ERB.new(internet_gateway_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def internet_gateway_spec_template
        template = <<-'EOF'
describe internet_gateway('<%= internet_gateway_id %>') do
  it { should exist }
<%- if @vpc_tag_name -%>
  it { should be_attached_to('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should be_attached_to('<%= @vpc_id %>') }
<%- end -%>
end
EOF
        template
      end
    end
  end
end
