module Awspec::Generator
  module Spec
    class Redshift
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          node_type master_username db_name availability_zone
          allow_version_upgrade number_of_nodes publicly_accessible encrypted
          kms_key_id enhanced_vpc_routing pending_actions maintenance_track_name
          elastic_resize_number_of_node_options
        )

        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        clusters = select_redshift_by_vpc_id(@vpc_id)
        specs = clusters.map do |cluster|
          sg_group_names = cluster[:vpc_security_groups].map do |sg|
            sg_id = sg.vpc_security_group_id
            ret = find_security_group(sg_id)
            ret[:group_name]
          end
          content = ERB.new(redshift_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      # rubocop:disable all
      def redshift_spec_template
        template = <<-'EOF'
describe redshift('<%= cluster.cluster_identifier %>') do
  it { should exist }
  it { should be_<%= cluster.cluster_status %> }
<% describes.each do |describe| %>
<%- if cluster.members.include?(describe.to_sym) && !cluster[describe.to_sym].nil? -%>
<%- if cluster[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= cluster[describe] %>' }
<%- else -%>
  its(:<%= describe %>) { should eq <%= cluster[describe] %> }
<%- end -%>
<%- end -%>
<% end %>
<% sg_group_names.each do |sg_group_name| %>
  it { should have_security_group('<%= sg_group_name %>') }
<% end %>
<%- if @vpc_tag_name -%>
  it { should belong_to_vpc('<%= @vpc_tag_name %>') }
<%- else -%>
  it { should belong_to_vpc('<%= @vpc_id %>') }
<%- end -%>
  it { should belong_to_cluster_subnet_group('<%= cluster.cluster_subnet_group_name %>') }
<% cluster.cluster_parameter_groups.each do |pg| %>
  it { should have_cluster_parameter_group('<%= pg.parameter_group_name %>').parameter_apply_status('<%= pg.parameter_apply_status %>') }
<% end %>
<% cluster.tags.each do |tag| %>
  it { should have_tag('<%= tag.key %>').value('<%= tag.value %>') }
<% end %>
end
EOF
        template
      end
    end
  end
end
