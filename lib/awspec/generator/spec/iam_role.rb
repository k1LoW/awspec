module Awspec::Generator
  module Spec
    class IamRole
      include Awspec::Helper::Finder
      def generate_all
        roles = select_all_iam_roles
        raise 'Not Found IAM Role' if roles.empty?
        specs = roles.map do |role|
          inline_policies = select_inline_policy_by_role_name(role.role_name).map do |policy_name|
            res = iam_client.get_role_policy({
                                               role_name: role.role_name,
                                               policy_name: policy_name
                                             })
            document = JSON.generate(JSON.parse(URI.decode(res.policy_document)))
            "it { should have_inline_policy('#{policy_name}').policy_document('#{document}') }"
          end
          content = ERB.new(iam_role_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def iam_role_spec_template
        template = <<-'EOF'
describe iam_role('<%= role.role_name %>') do
  it { should exist }
  its(:arn) { should eq '<%= role.arn %>' }
  its(:create_date) { should eq Time.parse('<%= role.create_date %>') }
<% select_iam_policy_by_role_name(role.role_name).each do |policy| %>  it { should have_iam_policy('<%= policy.policy_name %>') }
<% end %>
<%- inline_policies.each do |line| -%>
  <%= line %>
<%- end -%>
end
EOF
        template
      end
    end
  end
end
