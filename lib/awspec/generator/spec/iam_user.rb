module Awspec::Generator
  module Spec
    class IamUser
      include Awspec::Helper::Finder
      def generate_all
        users = select_all_iam_users
        raise 'Not Found IAM User' if users.empty?
        specs = users.map do |user|
          inline_policies = select_inline_policy_by_user_name(user.user_name).map do |policy_name|
            res = iam_client.get_user_policy({
                                               user_name: user.user_name,
                                               policy_name: policy_name
                                             })
            document = JSON.generate(JSON.parse(URI.decode(res.policy_document)))
            "it { should have_inline_policy('#{policy_name}').policy_document('#{document}') }"
          end
          content = ERB.new(iam_user_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def iam_user_spec_template
        template = <<-'EOF'
describe iam_user('<%= user.user_name %>') do
  it { should exist }
  its(:arn) { should eq '<%= user.arn %>' }
  its(:create_date) { should eq Time.parse('<%= user.create_date %>') }
<% select_iam_policy_by_user_name(user.user_name).each do |policy| %>  it { should have_iam_policy('<%= policy.policy_name %>') }
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
