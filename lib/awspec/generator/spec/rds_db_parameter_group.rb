module Awspec::Generator
  module Spec
    class RdsDbParameterGroup
      include Awspec::Helper::Finder
      def generate_by_paramater_group(paramater_group)
        @paramater_group = paramater_group
        res = select_all_rds_db_parameters(@paramater_group)
        ERB.new(db_paramater_group_template, nil, '-').result(binding).gsub(/^\n/, '')
      end

      def db_paramater_group_template
        template = <<-'EOF'
describe rds_db_parameter_group('<%= @paramater_group %>') do
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
