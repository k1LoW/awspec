# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class RdsDBCluster
      include Awspec::Helper::Finder
      def generate(db_cluster_identifier)
        cluster = find_db_cluster(db_cluster_identifier)
        raise 'Not Found RDS DB Cluster' unless cluster

        content(cluster)
      end

      # rubocop:disable all
      def rds_db_cluster_spec_template
        template = <<-'EOF'
describe rds_db_cluster('<%= cluster.db_cluster_identifier %>') do
  it { should exist }
  it { should be_<%= cluster.status %> }
<% cluster.vpc_security_groups.each do |sg| %>
  it { should have_security_group('<%= sg.vpc_security_group_id %>') }
<% end %>
<% cluster.db_cluster_members.each do |member| %>
  it { should have_cluster_member('<%= member.db_instance_identifier %>').is_writer(<%= member.is_cluster_writer %>) }
<% end %>
  its(:db_cluster_parameter_group) { should eq '<%= cluster.db_cluster_parameter_group %>' }
  its(:engine) { should eq '<%= cluster.engine %>' }
  its(:engine_version) { should eq '<%= cluster.engine_version %>' }
  its(:database_name) { should eq '<%= cluster.database_name %>' }
  its(:storage_encrypted) { should eq <%= cluster.storage_encrypted %> }
  its(:deletion_protection) { should eq <%= cluster.deletion_protection %> }
  its(:port) { should eq <%= cluster.port %> }
  its(:master_username) { should eq '<%= cluster.master_username %>' }
end
EOF
        template
      end

      private

      def content(cluster)
        ERB.new(rds_db_cluster_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
      end
    end
  end
end
