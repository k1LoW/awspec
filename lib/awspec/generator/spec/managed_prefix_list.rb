# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class ManagedPrefixList
      include Awspec::Helper::Finder
      def select_all_managed_prefix_lists
        res = ec2_client.describe_managed_prefix_lists
        res.prefix_lists
      end

      def generate_all
        prefix_lists = select_all_managed_prefix_lists
        raise 'Not Found Managed Prefix List.' if prefix_lists.empty?

        specs = prefix_lists.map do |prefix_list|
          entries = select_managed_prefix_list_entries(prefix_list.prefix_list_id)
          content = ERB.new(managed_prefix_list_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      def managed_prefix_list_spec_template
        <<-'EOF'
describe managed_prefix_list('<%= prefix_list.prefix_list_name %>') do
  it { should exist }
<% entries.each do |entry| %>
<% if entry.description.nil? %>
  it { should have_cidr('<%= entry.cidr %>') }
<% else %>
  it { should have_cidr('<%= entry.cidr %>').desc('<%= entry.description %>') }
<% end %>
<% end %>
  its(:entries_count) { should eq <%= entries.length %> }
  its(:prefix_list_id) { should eq '<%= prefix_list.prefix_list_id %>' }
  its(:address_family) { should eq '<%= prefix_list.address_family %>' }
  its(:state) { should eq '<%= prefix_list.state %>' }
  its(:prefix_list_arn) { should eq '<%= prefix_list.prefix_list_arn %>' }
<% if prefix_list.max_entries %>
  its(:max_entries) { should eq <%= prefix_list.max_entries %> }
<% end %>
<% if prefix_list.version %>
  its(:version) { should eq <%= prefix_list.version %> }
<% end %>
  its(:owner_id) { should eq '<%= prefix_list.owner_id %>' }
<% prefix_list.tags.each do |tag| %>
  it { should have_tag('<%= tag.key %>').value('<%= tag.value %>') }
<% end %>
end
EOF
      end
    end
  end
end
