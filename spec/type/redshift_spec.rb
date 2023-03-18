# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'redshift'

describe redshift('my-redshift') do
  it { should exist }
  it { should be_available }
  its(:node_type) { should eq 't2.medium' }
  its(:db_name) { should eq 'my-db' }
  its(:availability_zone) { should eq 'ap-northeast-1a' }
  it { should have_security_group('group-name-sg') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_cluster_subnet_group('my-sg') }
  it { should have_cluster_parameter_group('my-pg').parameter_apply_status('in-sync') }
  it { should have_tag('Name').value('my-cluster') }
end
