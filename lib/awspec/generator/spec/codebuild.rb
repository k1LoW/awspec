module Awspec::Generator
  module Spec
    class Codebuild
      include Awspec::Helper::Finder
      def generate_all
        projects = select_all_codebuild_projects
        raise 'Not Found CodeBuild Project' if projects.empty?
        ERB.new(codebuild_spec_template, nil, '-').result(binding).chomp
      end

      def codebuild_spec_template
        template = <<-'EOF'
<% projects.each do |project| %>
describe codebuild('<%= project %>') do
  it { should exist }
end
<% end %>
EOF
        template
      end
    end
  end
end
