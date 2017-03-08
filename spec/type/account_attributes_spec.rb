require 'spec_helper'
Awspec::Stub.load 'account_attributes'

describe 'account_attributes resource type' do
  describe account_attributes do
    its('ec2.supported_platforms') { should include 'VPC' }
    its('ec2.max_instances') { should eq 20 }
    its('ses_send_quota.max_24_hour_send') { should eq 200.0 }
    its('ses_send_quota.max_send_rate') { should eq 1.0 }
    its('ses_send_quota.sent_last_24_hours') { should eq 1.0 }
  end
end

describe 'separate attributes' do
  describe ec2_account_attributes do
    its(:supported_platforms) { should include 'VPC' }
    its(:max_instances) { should eq 20 }
  end

  describe ses_send_quota do
    its(:max_24_hour_send) { should eq 200.0 }
    its(:max_send_rate) { should eq 1.0 }
    its(:sent_last_24_hours) { should eq 1.0 }
  end

  describe ses_send_quota, account: '123456789012' do
    its(:max_24_hour_send) { should eq 200.0 }
    its(:max_send_rate) { should eq 1.0 }
    its(:sent_last_24_hours) { should eq 1.0 }
  end
end
