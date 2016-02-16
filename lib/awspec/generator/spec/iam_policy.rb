module Awspec::Generator
  module Spec
    class IamPolicy
      include Awspec::Helper::Finder
      def generate_all
        policies = select_all_attached_policies
        raise 'Not Found policy' if policies.empty?
        ERB.new(policy_spec_template, nil, '-').result(binding).chomp
      end

      # rubocop:disable all
      def policy_spec_template
        template = <<-'EOF'
<% policies.each do |policy| %>
describe iam_policy('<%= policy.policy_name %>') do
  it { should exist }
<%- if policy.is_attachable -%>
  it { should be_attachable }
<%- else -%>
  it { should_not be_attachable }
<%- end -%>
  its(:arn) { should eq '<%= policy.arn %>' }
  its(:update_date) { should eq Time.parse('<%= policy.update_date %>') }
  its(:attachment_count) { should eq <%= policy.attachment_count %> }
<%- users = select_attached_users(policy.arn) -%>
<%- if users.empty? -%>
  it { should_not be_attached_to_user }
<%- else -%>
<%- users.each do |user| -%>
  it { should     be_attached_to_user('<%= user.user_name %>') }
<%- end -%>
<%- end -%>
<%- groups = select_attached_groups(policy.arn) -%>
<%- if groups.empty? -%>
  it { should_not be_attached_to_group }
<%- else -%>
<%- groups.each do |group| -%>
  it { should     be_attached_to_group('<%= group.group_name %>') }
<%- end -%>
<%- end -%>
<%- roles = select_attached_roles(policy.arn) -%>
<%- if roles.empty? -%>
  it { should_not be_attached_to_role }
<%- else -%>
<%- roles.each do |role| -%>
  it { should     be_attached_to_role('<%= role.role_name %>') }
<%- end -%>
<%- end -%>
end
<% end %>
EOF
        template
      end
    end
  end
end
