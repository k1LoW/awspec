module Awspec::Generator
  module Spec
    class ElasticSearch
      include Awspec::Helper::Finder
      def generate_all
        domains = select_all_elasticsearch_domains
        raise 'Not Found alarm' if events.empty?
        ERB.new(domain_spec_template, nil, '-').result(binding).chomp
      end

      def domain_spec_template
        template = <<-'EOF'
<% domain.each do |domain| %>
describe elasticsearch('<%= domain.domain_name %>') do
  it { should exist }
  <% if domain.ebs_options.created %>
  it { should be_created }
  <% end %>
  <% if domain.ebs_options.deleted %>
  it { should be_deleted }
  <% end %>
  its(:elasticsearch_version) { should eq <%= domain.elasticsearch_version %> }
  its('elasticsearch_cluster_config.instance_type') { should eq <%= domain.elasticsearch_cluster_config.instance_type %> }
  its('ebs_options.ebs_enabled') { should eq <%= domain.ebs_options.ebs_enabled %> }
  <% if domain.ebs_options.ebs_enabled %>
  its('ebs_options.volume_type') { should eq <%= domain.ebs_options.ebs_volume_type %> }
  its('ebs_options.volume_size') { should eq <%= domain.ebs_options.ebs_volume_size %> }
  <% end %>
  it do
    should have_access_policies <<-policy
<%= JSON.pretty_generate(JSON.load(domain.access_policies)) %>
  policy
EOF
        template
      end
    end
  end
end
