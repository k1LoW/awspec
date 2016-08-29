module Awspec::Generator
  module Spec
    class IamGroup
      include Awspec::Helper::Finder
      def generate_all
        groups = select_all_iam_groups
        raise 'Not Found IAM Group' if groups.empty?
        specs = groups.map do |group|
          inline_policies = select_inline_policy_by_group_name(group.group_name).map do |policy_name|
            res = iam_client.get_group_policy({
                                                group_name: group.group_name,
                                                policy_name: policy_name
                                              })
            document = JSON.generate(JSON.parse(URI.decode(res.policy_document)))
            "it { should have_inline_policy('#{policy_name}').policy_document('#{document}') }"
          end
          content = ERB.new(iam_group_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def iam_group_spec_template
        template = <<-'EOF'
describe iam_group('<%= group.group_name %>') do
  it { should exist }
  its(:arn) { should eq '<%= group.arn %>' }
  its(:create_date) { should eq Time.parse('<%= group.create_date %>') }
<% select_iam_policy_by_group_name(group.group_name).each do |policy| %>  it { should have_iam_policy('<%= policy.policy_name %>') }
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
