# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Kms' do
  before do
    Awspec::Stub.load 'kms'
  end
  let(:kms) { Awspec::Generator::Spec::Kms.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'

describe kms('my-kms-key') do
  it { should exist }
  it { should be_enabled }
end
EOF
    expect(kms.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
