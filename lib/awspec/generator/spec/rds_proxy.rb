# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class RdsProxy
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc

        @vpc_id = vpc[:vpc_id]
        db_proxies = select_rds_proxy_by_vpc_id(@vpc_id)
        specs = db_proxies.map do |db_proxy|
          content = ERB.new(rds_proxy_spec_template, trim_mode: '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      # rubocop:disable all
      def rds_proxy_spec_template
        template = <<-'EOF'
describe rds_proxy('<%= db_proxy.db_proxy_name %>') do
  it { should exist }
  it { should be_<%= db_proxy.status %> }
  it { should belong_to_vpc('<%= @vpc_id %>') }
<% db_proxy.vpc_security_group_ids.each do |sg_group_id| %>
  it { should have_security_group('<%= sg_group_id %>') }
<% end %>
<% db_proxy.vpc_subnet_ids.each do |subnet_id| %>
  it { should belong_to_subnet('<%= subnet_id %>') }
<% end %>
end
EOF
        template
      end
    end
  end
end
