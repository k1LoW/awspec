require 'spec_helper'

describe Awspec::Generator::Spec::Policy do
  before do
    Awspec::Stub.load 'policy'
  end
  let(:policy) { Awspec::Generator::Spec::Policy.new }
  it 'generates spec' do
    spec = <<-'EOF'

describe policy('AmazonAPIGatewayAdministrator') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator' }
  its(:update_date) { should eq Time.parse('2015-07-09 17:34:45 UTC') }
  its(:attachment_count) { should eq 1 }
  it { should_not be_attached_to_user }
  it { should_not be_attached_to_group }
  it { should     be_attached_to_role('HelloIAmGodRole') }
end

describe policy('AmazonEC2RoleforDataPipelineRole') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforDataPipelineRole' }
  its(:update_date) { should eq Time.parse('2015-03-19 19:21:14 UTC') }
  its(:attachment_count) { should eq 1 }
  it { should_not be_attached_to_user }
  it { should_not be_attached_to_group }
  it { should     be_attached_to_role('HelloIAmGodRole') }
end
EOF
    expect(policy.generate_all.to_s).to eq spec
  end
end
