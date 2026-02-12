# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class Elasticache
      include Awspec::Helper::Finder
      def generate_all
        cache_clusters = collect_cache_clusters
        replication_groups = collect_replication_groups
        serverless_caches = collect_serverless_caches
        if cache_clusters.empty? && replication_groups.empty? && serverless_caches.empty?
          raise 'Not Found ElastiCache Resources'
        end

        ERB.new(elasticache_spec_template, trim_mode: '-').result(binding).gsub(/^\n/, '')
      end

      def elasticache_spec_template
        <<-'EOF'
<% cache_clusters.each do |cluster| %>
describe elasticache('<%= cluster.cache_cluster_id %>') do
  it { should exist }
  it { should be_available }
  it { should have_cache_parameter_group('<%= cluster.cache_parameter_group.cache_parameter_group_name %>') }
  it { should belong_to_cache_subnet_group('<%= cluster.cache_subnet_group_name %>') }
<% unless cluster.replication_group_id.nil? %>
  its(:replication_group_id) { should eq '<%= cluster.replication_group_id %>' }
<% end %>
  its(:cache_type) { should eq 'cache_cluster' }
  its(:engine) { should eq '<%= cluster.engine %>' }
  its(:engine_version) { should eq '<%= engine_version_for(cluster) %>' }
  its(:cache_node_type) { should eq '<%= cluster.cache_node_type %>' }
  its(:num_nodes) { should eq <%= cluster.num_cache_nodes %> }
<% unless cluster.snapshot_retention_limit.nil? %>
  its(:snapshot_retention_limit) { should eq <%= cluster.snapshot_retention_limit %> }
  its(:snapshot_window) { should eq '<%= cluster.snapshot_window %>' }
<% end %>
end
<% end %>
<% replication_groups.each do |group| %>
describe elasticache('<%= group.replication_group_id %>') do
  it { should exist }
  it { should be_available }
<% if group.respond_to?(:cache_parameter_group) && group.cache_parameter_group %>
  it { should have_cache_parameter_group('<%= group.cache_parameter_group.cache_parameter_group_name %>') }
<% end %>
<% if group.respond_to?(:cache_subnet_group_name) && group.cache_subnet_group_name %>
  it { should belong_to_cache_subnet_group('<%= group.cache_subnet_group_name %>') }
<% end %>
  its(:cache_type) { should eq 'replication_group' }
  its(:engine) { should eq '<%= group.engine %>' }
<% unless engine_version_for(group).nil? %>
  its(:engine_version) { should eq '<%= engine_version_for(group) %>' }
<% end %>
  its(:cluster_mode_enabled) { should eq <%= replication_group_cluster_mode_enabled(group) %> }
<% unless replication_group_node_count(group).nil? %>
  its(:num_nodes) { should eq <%= replication_group_node_count(group) %> }
<% end %>
end
<% end %>
<% serverless_caches.each do |cache| %>
describe elasticache('<%= cache.serverless_cache_name %>') do
  it { should exist }
  it { should be_available }
  its(:cache_type) { should eq 'serverless_cache' }
  its(:serverless) { should eq true }
  its(:engine) { should eq '<%= cache.engine %>' }
<% unless engine_version_for(cache).nil? %>
  its(:engine_version) { should eq '<%= engine_version_for(cache) %>' }
<% end %>
end
<% end %>
EOF
      end

      private

      def collect_cache_clusters
        opt = {}
        clusters = []
        loop do
          res = elasticache_client.describe_cache_clusters(opt)
          clusters.push(*res.cache_clusters)
          break if res.marker.nil?

          opt = { marker: res.marker }
        end
        clusters
      end

      def collect_replication_groups
        opt = {}
        groups = []
        loop do
          res = elasticache_client.describe_replication_groups(opt)
          groups.push(*res.replication_groups)
          token = pagination_token(res)
          break if token.nil?

          opt = pagination_param(res, token)
        end
        groups
      end

      def collect_serverless_caches
        opt = {}
        caches = []
        loop do
          res = elasticache_client.describe_serverless_caches(opt)
          caches.push(*res.serverless_caches)
          token = pagination_token(res)
          break if token.nil?

          opt = pagination_param(res, token)
        end
        caches
      rescue StandardError
        []
      end

      def pagination_token(response)
        return response.marker if response.respond_to?(:marker) && response.marker
        return response.next_token if response.respond_to?(:next_token) && response.next_token

        nil
      end

      def pagination_param(response, token)
        return { marker: token } if response.respond_to?(:marker)
        return { next_token: token } if response.respond_to?(:next_token)

        {}
      end

      def engine_version_for(resource)
        return resource.engine_version if resource.respond_to?(:engine_version) && resource.engine_version
        return resource.major_engine_version if resource.respond_to?(:major_engine_version)

        nil
      end

      def replication_group_cluster_mode_enabled(group)
        return group.cluster_enabled if group.respond_to?(:cluster_enabled)
        return group.cluster_mode if group.respond_to?(:cluster_mode)

        false
      end

      def replication_group_node_count(group)
        if group.respond_to?(:node_groups) && group.node_groups
          return group.node_groups.sum do |node_group|
            next 0 unless node_group.respond_to?(:node_group_members)

            node_group.node_group_members&.count.to_i
          end
        end

        return group.member_clusters.count if group.respond_to?(:member_clusters)

        nil
      end
    end
  end
end
