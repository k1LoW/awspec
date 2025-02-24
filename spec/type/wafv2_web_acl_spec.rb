# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'wafv2_web_acl'

describe wafv2_web_acl('my-wafv2-web-acl'), scope: 'REGIONAL' do
  it { should exist }
  its(:default_action) { should eq 'ALLOW' }
  its(:name) { should eq 'my-wafv2-web-acl' }
  its(:id) { should eq 'a64cc988-40ec-4c4e-ab80-c9acbea42103' }
  its(:arn) do
    should eq 'arn:aws:wafv2:ap-northeast-1:123456789012:regional/webacl/'\
              'my-wafv2-web-acl/a64cc988-40ec-4c4e-ab80-c9acbea42103'
  end
  its(:description) { should eq 'test web acl' }
  its(:capacity) { should eq 1275 }
  its(:managed_by_firewall_manager) { should eq false }
  its(:label_namespace) { should eq 'awswaf:123456789012:webacl:my-wafv2-web-acl:' }
  its(:retrofitted_by_firewall_manager) { should eq false }
  it { should have_rule('AWS-AWSManagedRulesCommonRuleSet') }
  it { should have_rule('AWS-AWSManagedRulesKnownBadInputsRuleSet').order(1) }
  it { should have_rule('AWS-AWSManagedRulesLinuxRuleSet').order(2).override_action('NONE') }
end
