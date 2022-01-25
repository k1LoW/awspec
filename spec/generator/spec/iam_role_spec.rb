# frozen_string_literal: true

require 'spec_helper'

describe Awspec::Generator::Spec::IamRole do
  before do
    Awspec::Stub.load 'iam_role'
  end
  let(:role) { Awspec::Generator::Spec::IamRole.new }
  it 'generates spec' do
    spec = <<-'EOF'
describe iam_role('my-iam-role') do
  it { should exist }
  its(:arn) { should eq 'arn:aws:iam::123456789012:role/my-iam-role' }
  its(:create_date) { should eq Time.parse('2015-01-02 09:00:00 UTC') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should have_inline_policy('AllowS3BucketAccess').policy_document('{"Statement":[{"Action":["s3:ListAllMyBuckets"],"Effect":"Allow","Resource":"arn:aws:s3:::*"},{"Action":"s3:*","Effect":"Allow","Resource":["arn:aws:s3:::my-bucket","arn:aws:s3:::my-bucket/*"]}]}') }
end
EOF
    expect(role.generate_all.to_s).to eq spec
  end
end
