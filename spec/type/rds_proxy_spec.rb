# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'rds_proxy'

describe rds_proxy('my-rds-proxy') do
  it { should exist }
  it { should be_available }
  it { should_not be_suspended }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-db-sg') }
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
  its(:engine_family) { should eq 'MYSQL' }
  its(:require_tls) { should eq true }
  its(:idle_client_timeout) { should eq 5400 }
  its(:debug_logging) { should eq false }
end
