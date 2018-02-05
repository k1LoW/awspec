module Awspec::Generator
  module Spec
    class RdsDbClusterParameterGroup
      include Awspec::Helper::Finder
      def generate_by_parameter_group(parameter_group)
        @parameter_group = parameter_group
        res = select_all_rds_db_cluster_parameters(@parameter_group)
        ERB.new(db_cluster_parameter_group_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def db_cluster_parameter_group_template
        template = <<-'EOF'
describe rds_db_cluster_parameter_group('<%= @parameter_group %>') do
<% res.each do |key, value| %>
  its('<%= key %>') { should eq '<%= value %>' }
<% end %>
end
EOF
        template
      end
    end
  end
end
