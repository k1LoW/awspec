# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class RedshiftClusterParameterGroup
      include Awspec::Helper::Finder
      def generate_by_parameter_group(parameter_group)
        @parameter_group = parameter_group
        res = select_all_redshift_cluster_parameters(@parameter_group)
        ERB.new(redshift_cluster_parameters_spec_template, trim_mode: '-').result(binding).gsub(/^\n/, '')
      end

      def redshift_cluster_parameters_spec_template
        <<-'EOF'
describe redshift_cluster_parameter_group('<%= @parameter_group %>') do
<% res.each do |key, value| %>
  its('<%= key %>') { should eq '<%= value %>' }
<% end %>
end
EOF
      end
    end
  end
end
