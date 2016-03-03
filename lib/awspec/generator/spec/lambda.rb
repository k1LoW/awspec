module Awspec::Generator
  module Spec
    class Lambda
      include Awspec::Helper::Finder
      def generate_all
        lambda_functions = select_all_lambda_functions
        raise 'Not Found lambda' if lambda_functions.empty?
        ERB.new(lambda_spec_template, nil, '-').result(binding).chomp
      end

      def lambda_spec_template
        template = <<-'EOF'
<% lambda_functions.each do |function| %>
describe lambda('<%= function.function_name %>') do
  it { should exist }
  its(:description) { should eq '<%= function.description %>' }
  its(:runtime) { should eq '<%= function.runtime %>' }
  its(:handler) { should eq '<%= function.handler %>' }
  its(:code_size) { should eq <%= function.code_size %> }
  its(:timeout) { should eq <%= function.timeout %> }
  its(:memory_size) { should eq <%= function.memory_size %> }
end
<% end %>
EOF
        template
      end
    end
  end
end
