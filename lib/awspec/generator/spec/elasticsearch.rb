module Awspec::Generator
  module Spec
    class Elasticsearch
      include Awspec::Helper::Finder
      def generate_all
        domains = select_all_elasticsearch_domains
        raise 'Not Found Domain' if domains.empty?
        ERB.new(domain_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def domain_spec_template
        template = <<-'EOF'
<% domains.each do |domain| %>
describe elasticsearch('<%= domain.domain_status.domain_name %>') do
  it { should exist }
<% if domain.domain_status.created %>
  it { should be_created }
<% end %>
<% if domain.domain_status.deleted %>
  it { should be_deleted }
<% end %>
  its(:elasticsearch_version) { should eq '<%= domain.domain_status.elasticsearch_version %>' }
  its('elasticsearch_cluster_config.instance_type') { should eq '<%= domain.domain_status.elasticsearch_cluster_config.instance_type %>' }
  its('ebs_options.ebs_enabled') { should eq <%= domain.domain_status.ebs_options.ebs_enabled %> }
<% if domain.domain_status.ebs_options.ebs_enabled -%>
  its('ebs_options.volume_type') { should eq '<%= domain.domain_status.ebs_options.volume_type %>' }
  its('ebs_options.volume_size') { should eq <%= domain.domain_status.ebs_options.volume_size %> }
<% end %>
  it do
    should have_access_policies <<-policy
<%= JSON.pretty_generate(JSON.load(domain.domain_status.access_policies)) %>
  policy
  end
end
<% end %>
EOF
        template
      end
    end
  end
end
