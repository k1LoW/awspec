require 'spec_helper'

describe Awspec::Generator::Spec::Ebs do
  before do
    Awspec::Stub.load 'ebs'
  end
  let(:ebs) { Awspec::Generator::Spec::Ebs.new }
  it 'generates spec' do
    spec = <<-'EOF'
describe ebs('my-volume') do
  it { should exist }
  it { should be_in_use }
  its(:size) { should eq 100 }
  its(:volume_type) { should eq 'gp2' }
  it { should be_attached_to('my-ec2') }
end
EOF
    expect(ebs.generate_all.to_s).to eq spec
  end
end
