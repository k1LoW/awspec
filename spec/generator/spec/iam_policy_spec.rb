# frozen_string_literal: true

require 'spec_helper'

describe Awspec::Generator::Spec::IamPolicy do
  before do
    Awspec::Stub.load 'iam_policy'
  end
  let(:policy) { Awspec::Generator::Spec::IamPolicy.new }
  it 'generates spec' do
    spec = <<-'EOF'

describe iam_policy('my-iam-policy') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/my-iam-policy' }
  its(:update_date) { should eq Time.parse('2015-01-02 10:00:00 UTC') }
  its(:attachment_count) { should eq 1 }
  it { should     be_attached_to_user('my-iam-user') }
  it { should     be_attached_to_group('my-iam-group') }
  it { should     be_attached_to_role('HelloIAmGodRole') }
end

describe iam_policy('AmazonAPIGatewayAdministrator') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/AmazonAPIGatewayAdministrator' }
  its(:update_date) { should eq Time.parse('2015-07-09 17:34:45 UTC') }
  its(:attachment_count) { should eq 1 }
  it { should     be_attached_to_user('my-iam-user') }
  it { should     be_attached_to_group('my-iam-group') }
  it { should     be_attached_to_role('HelloIAmGodRole') }
end

describe iam_policy('AmazonEC2RoleforDataPipelineRole') do
  it { should exist }
  it { should be_attachable }
  its(:arn) { should eq 'arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforDataPipelineRole' }
  its(:update_date) { should eq Time.parse('2015-03-19 19:21:14 UTC') }
  its(:attachment_count) { should eq 1 }
  it { should     be_attached_to_user('my-iam-user') }
  it { should     be_attached_to_group('my-iam-group') }
  it { should     be_attached_to_role('HelloIAmGodRole') }
end
EOF
    expect(policy.generate_all.to_s).to eq spec
  end
end
