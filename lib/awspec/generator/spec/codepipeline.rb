# frozen_string_literal: true

module Awspec::Generator
  module Spec
    class Codepipeline
      include Awspec::Helper::Finder
      def generate_all
        pipelines = select_all_codepipelines
        raise 'Not Found CodePipeline' if pipelines.empty?

        ERB.new(codepipeline_spec_template, nil, '-').result(binding).chomp
      end

      def codepipeline_spec_template
        <<-'EOF'
<% pipelines.each do |pipeline| %>
describe codepipeline('<%= pipeline.name %>') do
  it { should exist }
  its(:name) { should eq '<%= pipeline.name %>' }
  its(:version) { should eq <%= pipeline.version %> }
  its(:pipeline_type) { should eq '<%= pipeline.pipeline_type %>' }
  its(:execution_mode) { should eq '<%= pipeline.execution_mode %>' }
end
<% end %>
EOF
      end
    end
  end
end
