require 'spec_helper'

describe Awspec::Generator::Spec::IamGroup do
  before do
    Awspec::Stub.load 'iam_group'
  end
  let(:group) { Awspec::Generator::Spec::IamGroup.new }
  it 'generates spec' do
    spec = <<-'EOF'
describe iam_group('my-iam-group') do
  it { should exist }
  its(:arn) { should eq 'arn:aws:iam::123456789012:group/my-iam-group' }
  its(:create_date) { should eq Time.parse('2015-01-02 11:00:00 UTC') }
  it { should have_iam_policy('ReadOnlyAccess') }
  it { should have_inline_policy('InlineEC2FullAccess').document('{"Statement":[{"Action":"ec2:*","Effect":"Allow","Resource":"*"},{"Effect":"Allow","Action":"elasticloadbalancing:*","Resource":"*"},{"Effect":"Allow","Action":"cloudwatch:*","Resource":"*"},{"Effect":"Allow","Action":"autoscaling:*","Resource":"*"}]}') }
end
EOF
    expect(group.generate_all.to_s).to eq spec
  end
end
