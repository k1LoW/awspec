require 'spec_helper'

describe 'Awspec::Generator::Spec::NlbListener' do
  before do
    Awspec::Stub.load 'nlb_listener'
  end
  let(:nlb_listener) { Awspec::Generator::Spec::NlbListener.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe nlb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:load_balancer_arn) { should eq 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-nlb/1aa1bb1cc1ddee11' }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/defaaaaaaaultbbbb') }
  it do
    should have_rule.priority('default')
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:targetgroup/my-nlb-target-group/73e2d6bc24d8a067'}])
  end
end
EOF
    expect(nlb_listener.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
