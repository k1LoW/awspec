# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Codepipeline' do
  before do
    Awspec::Stub.load 'codepipeline'
  end
  let(:codepipeline) { Awspec::Generator::Spec::Codepipeline.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'

describe codepipeline('my-codepipeline1') do
  it { should exist }
  its(:name) { should eq 'my-codepipeline1' }
  its(:version) { should eq 1 }
  its(:pipeline_type) { should eq 'V2' }
  its(:execution_mode) { should eq 'QUEUED' }
end

describe codepipeline('my-codepipeline2') do
  it { should exist }
  its(:name) { should eq 'my-codepipeline2' }
  its(:version) { should eq 1 }
  its(:pipeline_type) { should eq 'V2' }
  its(:execution_mode) { should eq 'QUEUED' }
end
EOF
    expect(codepipeline.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
