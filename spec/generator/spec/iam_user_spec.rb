require 'spec_helper'

describe Awspec::Generator::Spec::IamUser do
  before do
    Awspec::Stub.load 'iam_user'
  end
  let(:user) { Awspec::Generator::Spec::IamUser.new }
  it 'generates spec' do
    spec = <<-'EOF'
describe iam_user('my-iam-user') do
  it { should exist }
  its(:arn) { should eq 'arn:aws:iam::123456789012:user/my-iam-user' }
  its(:create_date) { should eq Time.parse('2014-12-31 15:00:00 UTC') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should have_inline_policy('AllowS3BucketAccess').document('{"Statement":[{"Action":["s3:ListAllMyBuckets"],"Effect":"Allow","Resource":"arn:aws:s3:::*"},{"Action":"s3:*","Effect":"Allow","Resource":["arn:aws:s3:::my-bucket","arn:aws:s3:::my-bucket/*"]}]}') }
end
EOF
    expect(user.generate_all.to_s).to eq spec
  end
end
