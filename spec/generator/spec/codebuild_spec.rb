# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Codebuild' do
  before do
    Awspec::Stub.load 'codebuild'
  end
  let(:codebuild) { Awspec::Generator::Spec::Codebuild.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'

describe codebuild('my-codebuild1') do
  it { should exist }
end

describe codebuild('my-codebuild2') do
  it { should exist }
end
EOF
    expect(codebuild.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
