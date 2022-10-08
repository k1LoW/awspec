# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
require 'spec_helper'

describe 'Awspec::Generator::Spec::AlbListener' do
  before do
    Awspec::Stub.load 'alb_listener'
  end
  let(:alb_listener) { Awspec::Generator::Spec::AlbListener.new }
  it 'generate_by_vpc_id generate spec' do
    spec = <<-'EOF'
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:load_balancer_arn) { should eq 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11' }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/7777778efc522ab2/7777778efc522ab2') }
  it do
    should have_rule.priority('50')
      .conditions([{field: 'host-header', values: ["admin.example.com"]}, {field: 'path-pattern', values: ["/admin/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/55556bc24d8a067/55556bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions([{field: 'path-pattern', values: ["/img/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/defaaaaaaaultbbbb') }
  it do
    should have_rule.priority('default')
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:targetgroup/my-targets/73e2d6bc24d8a067'}])
  end
end

describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:load_balancer_arn) { should eq 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11' }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/7777778efc522ab2/7777778efc522ab2') }
  it do
    should have_rule.priority('50')
      .conditions([{field: 'host-header', values: ["admin.example.com"]}, {field: 'path-pattern', values: ["/admin/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/55556bc24d8a067/55556bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions([{field: 'path-pattern', values: ["/img/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/defaaaaaaaultbbbb') }
  it do
    should have_rule.priority('default')
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:targetgroup/my-targets/73e2d6bc24d8a067'}])
  end
end

describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:load_balancer_arn) { should eq 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:loadbalancer/app/my-alb/1aa1bb1cc1ddee11' }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/7777778efc522ab2/7777778efc522ab2') }
  it do
    should have_rule.priority('50')
      .conditions([{field: 'host-header', values: ["admin.example.com"]}, {field: 'path-pattern', values: ["/admin/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/55556bc24d8a067/55556bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions([{field: 'path-pattern', values: ["/img/*"]}])
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067'}])
  end
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/defaaaaaaaultbbbb') }
  it do
    should have_rule.priority('default')
      .actions([{type: 'forward', target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:targetgroup/my-targets/73e2d6bc24d8a067'}])
  end
end
EOF
    expect(alb_listener.generate_by_vpc_id('my-vpc').to_s.gsub(/\n/, "\n")).to eq spec
  end
end
