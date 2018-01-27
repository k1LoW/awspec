require 'spec_helper'
Awspec::Stub.load 'nlb_listener'

# rubocop:disable Metrics/LineLength
describe nlb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-nlb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/defaaaaaaaultbbbb') }
  it do
    should have_rule
      .priority('default')
      .actions(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it { should have_rule.actions(target_group_name: 'my-nlb-target-group', type: 'forward') }
end
