# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class RdsDBParameterGroup
      include Awspec::Helper::Finder
      def generate_by_parameter_group(parameter_group)
        @parameter_group = parameter_group
        res = select_all_rds_db_parameters(@parameter_group)
        ERB.new(db_parameter_group_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def db_parameter_group_template
        <<-'EOF'
describe rds_db_parameter_group('<%= @parameter_group %>') do
<% res.each do |key, value| %>
  its('<%= key %>') { should eq '<%= value %>' }
<% end %>
end
EOF
      end
    end
  end
end
