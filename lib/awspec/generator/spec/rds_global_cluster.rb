# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class RdsGlobalCluster
      include Awspec::Helper::Finder
      def generate(global_cluster_identifier)
        cluster = find_global_cluster(global_cluster_identifier)
        raise 'Not Found RDS Global Cluster' unless cluster

        content(cluster)
      end

      # rubocop:disable all
      def rds_global_cluster_spec_template
        template = <<-'EOF'
describe rds_global_cluster('<%= cluster.global_cluster_identifier %>') do
  it { should exist }
  it { should be_<%= cluster.status %> }
<% cluster.global_cluster_members.each do |member| %>
  it { should have_cluster_member('<%= member.db_cluster_arn %>').is_writer(<%= member.is_writer %>) }
<% end %>
  its(:engine) { should eq '<%= cluster.engine %>' }
  its(:engine_version) { should eq '<%= cluster.engine_version %>' }
  its(:database_name) { should eq '<%= cluster.database_name %>' }
  its(:storage_encrypted) { should eq <%= cluster.storage_encrypted %> }
  its(:deletion_protection) { should eq <%= cluster.deletion_protection %> }
end
EOF
        template
      end

      private

      def content(cluster)
        ERB.new(rds_global_cluster_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end
    end
  end
end
