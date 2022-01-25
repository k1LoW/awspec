# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class Elasticache
      include Awspec::Helper::Finder
      def generate_all
        opt = {}
        clusters = []
        loop do
          res = elasticache_client.describe_cache_clusters(opt)
          clusters.push(*res.cache_clusters)
          break if res.marker.nil?

          opt = { marker: res.marker }
        end
        raise 'Not Found Cache Clusters' if clusters.empty?

        ERB.new(cache_clusters_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def cache_clusters_spec_template
        template = <<-'EOF'
<% clusters.each do |cluster| %>
describe elasticache('<%= cluster.cache_cluster_id %>') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('<%= cluster.cache_parameter_group.cache_parameter_group_name %>') }
  it { should belong_to_cache_subnet_group('<%= cluster.cache_subnet_group_name %>') }
<% unless cluster.replication_group_id.nil? %>
  its(:replication_group_id) { should eq '<%= cluster.replication_group_id %>' }
<% end %>
  its(:engine) { should eq '<%= cluster.engine %>' }
  its(:engine_version) { should eq '<%= cluster.engine_version %>' }
  its(:cache_node_type) { should eq '<%= cluster.cache_node_type %>' }
<% unless cluster.snapshot_retention_limit.nil? %>
  its(:snapshot_retention_limit) { should eq <%= cluster.snapshot_retention_limit %> }
  its(:snapshot_window) { should eq '<%= cluster.snapshot_window %>' }
<% end %>
end
<% end %>
EOF
        template
      end
    end
  end
end
