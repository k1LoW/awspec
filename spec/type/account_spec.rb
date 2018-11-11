require 'spec_helper'
Awspec::Stub.load 'account'

describe 'Use `account` type' do
  describe account do
    its(:id) { should eq '123456789012' }
    its(:account) { should eq '123456789012' }
    its(:arn) { should eq 'arn:aws:iam::123456789012:user/Alice' }
    its(:user_id) { should eq 'AKIAI44QH8DHBEXAMPLE' }
    its('ec2.supported_platforms') { should include 'VPC' }
    its('ec2.max_instances') { should eq 20 }
    its('rds.DBInstances.used') { should eq 0 }
    its('rds.DBInstances.max') { should eq 40 }
    its('rds.ReservedDBInstances.used') { should eq 0 }
    its('lambda.total_code_size.limit') { should eq 80_530_636_800 }
    its('lambda.total_code_size.usage') { should eq 2_034_651_562 }
    its('lambda.function_count.usage') { should eq 8 }
    its('ses.max_24_hour_send') { should eq 200.0 }
    its('ses.max_send_rate') { should eq 1.0 }
    its('ses.sent_last_24_hours') { should eq 1.0 }
  end
end

describe 'Use `account_attribute` type' do
  describe account_attribute('ec2') do
    its(:supported_platforms) { should include 'VPC' }
    its(:max_instances) { should eq 20 }
  end

  describe account_attribute('rds') do
    its('DBInstances.used') { should eq 0 }
    its('DBInstances.max') { should eq 40 }
  end

  describe account_attribute('lambda') do
    its('total_code_size.limit') { should eq 80_530_636_800 }
    its('total_code_size.usage') { should eq 2_034_651_562 }
    its('function_count.usage') { should eq 8 }
  end

  describe account_attribute('ses'), region: 'us-east-1' do
    its(:max_24_hour_send) { should eq 200.0 }
    its(:max_send_rate) { should eq 1.0 }
    its(:sent_last_24_hours) { should eq 1.0 }
  end
end

describe 'Use separated attribute types' do
  describe ec2_account_attributes do
    its(:supported_platforms) { should include 'VPC' }
    its(:max_instances) { should eq 20 }
  end

  describe rds_account_attributes do
    its('DBInstances.used') { should eq 0 }
    its('DBInstances.max') { should eq 40 }
  end

  describe lambda_account_settings do
    its('total_code_size.limit') { should eq 80_530_636_800 }
    its('total_code_size.usage') { should eq 2_034_651_562 }
    its('function_count.usage') { should eq 8 }
  end

  describe ses_send_quota, region: 'us-east-1' do
    its(:max_24_hour_send) { should eq 200.0 }
    its(:max_send_rate) { should eq 1.0 }
    its(:sent_last_24_hours) { should eq 1.0 }
  end
end
