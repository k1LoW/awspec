# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class Wafv2WebAcl
      include Awspec::Helper::Finder
      def generate_by_scope(scope)
        web_acls = select_all_web_acls(scope)
        raise 'Not Found WAFV2 Web ACL' if web_acls.empty?

        specs = web_acls.map do |acl|
          web_acl = get_web_acl(scope, acl.name, acl.id)
          ERB.new(wafv2_web_acl_spec_template, trim_mode: '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def wafv2_web_acl_spec_template
        <<-'EOF'
describe wafv2_web_acl('<%= web_acl.name %>'), scope: '<%= scope %>' do
  it { should exist }
  its(:name) { should eq '<%= web_acl.name %>' }
  its(:id) { should eq '<%= web_acl.id %>' }
  its(:arn) { should eq '<%= web_acl.arn %>' }
  its(:default_action) { should eq '<%= web_acl.default_action.allow ? 'ALLOW' : 'BLOCK' %>' }
  its(:description) { should eq '<%= web_acl.description %>' }
  its(:capacity) { should eq <%= web_acl.capacity %> }
  its(:managed_by_firewall_manager) { should eq <%= web_acl.managed_by_firewall_manager %> }
  its(:label_namespace) { should eq '<%= web_acl.label_namespace %>' }
  its(:retrofitted_by_firewall_manager) { should eq <%= web_acl.retrofitted_by_firewall_manager %> }
<% web_acl.rules.each do |rule| %>
  it { should have_rule('<%= rule.name %>').order(<%= rule.priority %>) }
<% end %>
end
EOF
      end
    end
  end
end
