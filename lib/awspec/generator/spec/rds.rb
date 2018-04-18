module Awspec::Generator
  module Spec
    class Rds
      include Awspec::Helper::Finder
      def generate_by_vpc_id(vpc_id)
        describes = %w(
          db_instance_identifier db_instance_class multi_az availability_zone
        )
        vpc = find_vpc(vpc_id)
        raise 'Not Found VPC' unless vpc
        @vpc_id = vpc[:vpc_id]
        @vpc_tag_name = vpc.tag_name
        db_instances = select_rds_by_vpc_id(@vpc_id)
        specs = db_instances.map do |db_instance|
          instance_id = db_instance[:db_instance_identifier]
          sg_group_names = db_instance[:vpc_security_groups].map do |sg|
            sg_id = sg.vpc_security_group_id
            ret = find_security_group(sg_id)
            ret[:group_name]
          end
          content = ERB.new(rds_spec_template, nil, '-').result(binding).gsub(/^\n/, '')
        end
        specs.join("\n")
      end

      # rubocop:disable all
      def rds_spec_template
        template = <<-'EOF'
describe rds('<%= instance_id %>') do
  it { should exist }
  it { should be_<%= db_instance.db_instance_status %> }
<% describes.each do |describe| %>
<%- if db_instance.members.include?(describe.to_sym) && !db_instance[describe.to_sym].nil? -%>
<%- if db_instance[describe].is_a?(String) -%>
  its(:<%= describe %>) { should eq '<%= db_instance[describe] %>' }
<%- else -%>
  its(:<%= describe %>) { should eq <%= db_instance[describe] %> }
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
  it { should belong_to_db_subnet_group('<%= db_instance.db_subnet_group.db_subnet_group_name %>') }
<% db_instance.db_parameter_groups.each do |pg| %>
  it { should have_db_parameter_group('<%= pg.db_parameter_group_name %>').parameter_apply_status('<%= pg.parameter_apply_status %>') }
<% end %>
<% db_instance.option_group_memberships.each do |og| %>
  it { should have_option_group('<%= og.option_group_name %>').status('<%= og.status %>') }
<% end %>
end
EOF
        template
      end
    end
  end
end
