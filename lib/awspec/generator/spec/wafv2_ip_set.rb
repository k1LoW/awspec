# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class Wafv2IpSet
      include Awspec::Helper::Finder
      def generate_by_scope(scope)
        ip_sets = select_all_ip_sets(scope)
        raise 'Not Found WAFV2 IP sets' if ip_sets.empty?

        specs = ip_sets.map do |i|
          ip_set = get_ip_set(scope, i.name, i.id)
          ERB.new(wafv2_ip_set_spec_template, trim_mode: '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def wafv2_ip_set_spec_template
        <<-'EOF'
describe wafv2_ip_set('<%= ip_set.name %>'), scope: '<%= scope %>' do
  it { should exist }
  its(:name) { should eq '<%= ip_set.name %>' }
  its(:id) { should eq '<%= ip_set.id %>' }
  its(:arn) { should eq '<%= ip_set.arn %>' }
  its(:description) { should eq '<%= ip_set.description %>' }
  its(:ip_address_version) { should eq '<%= ip_set.ip_address_version %>' }
<% ip_set.addresses.each do |address| %>
  it { should have_ip_address('<%= address %>') }
<% end %>
end
EOF
      end
    end
  end
end
