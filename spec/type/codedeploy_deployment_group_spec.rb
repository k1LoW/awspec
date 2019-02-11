require 'spec_helper'
Awspec::Stub.load 'codedeploy_deployment_group'

describe codedeploy_deployment_group('my-codedeploy-deployment-group'), application_name: 'my-codedeploy-application' do
  it { should exist }
  its(:application_name) { should eq 'my-codedeploy-application' }
  its(:deployment_config_name) { should eq 'CodeDeployDefault.OneAtATime' }
  its(:deployment_group_id) { should eq 'cdac3220-0e64-4d63-bb50-e68faEXAMPLE' }
  its(:service_role_arn) { should eq 'arn:aws:iam::80398EXAMPLE:role/CodeDeployDemoRole' }
  it { should have_autoscaling_group('my-autoscaling-group') }
end
