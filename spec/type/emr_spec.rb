require 'spec_helper'
Awspec::Stub.load 'emr'

describe emr('my-emr') do
  it { should exist }
  it { should be_running }
  it { should be_ok }
  it { should be_healthy }
  it { should be_ready }

  its(:name) { should eq 'my cluster' }
  its(:log_uri) { should eq 's3n://aws-logs-232939870606-us-east-1/elasticmapreduce/' }
  its(:applications) { should include({ name: 'Spark', version: '2.3.1' }) }
  its(:tags) { should include({ Name: 'My Cluster' }) }
  its(:auto_scaling_role) { should eq 'EMR_AutoScaling_DefaultRole' }
  its(:scale_down_behavior) { should eq 'TERMINATE_AT_TASK_COMPLETION' }
  its(:instance_collection_type) { should eq 'INSTANCE_FLEET' }
  its(:ebs_root_volume_size) { should eq 30 }
  its(:security_configuration) { should eq 'sg-1828281-madeup' }
  its(:master_public_dns_name) { 'ec2-54-167-31-38.compute-1.amazonaws.com' }
  its('kerberos_attributes.realm') { should eq 'EXAMPLE.COM' }
  its('kerberos_attributes.kdc_admin_password') { should eq 'password' }
  its('kerberos_attributes.cross_realm_trust_principal_password') { should eq 'emr-password' }
  its('kerberos_attributes.ad_domain_join_user') { should eq 'johny' }
  its('kerberos_attributes.ad_domain_join_password') { should eq 'begood' }
  its('ec2_instance_attributes.ec2_key_name') { should eq 'my-key' }
  its('ec2_instance_attributes.ec2_subnet_id') { should eq 'sb-0bfc9360' }
  its('ec2_instance_attributes.requested_ec2_subnet_ids') { should eq [] }
  its('ec2_instance_attributes.emr_managed_master_security_group') { should eq 'sg-0bfc9360' }
  its('ec2_instance_attributes.emr_managed_slave_security_group') { should eq 'sg-0bfc9360' }
  its('ec2_instance_attributes.service_access_security_group') { should eq 'sg-0bfc9360' }
  its('ec2_instance_attributes.iam_instance_profile') { should eq 'EMR_EC2_DefaultRole' }
  its('ec2_instance_attributes.ec2_availability_zone') { should eq 'us-east-1a' }
end
