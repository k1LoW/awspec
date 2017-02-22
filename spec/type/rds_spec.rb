require 'spec_helper'
Awspec::Stub.load 'rds'

describe rds('my-rds') do
  it { should exist }
  it { should be_available }
  it { should_not be_maintenance }
  its(:db_instance_class) { should eq 'db.t2.medium' }
  it { should have_security_group('sg-5a6b7cd8') }
  it { should have_security_group('group-name-sg') }
  it { should have_security_group('my-db-sg') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_db_subnet_group('my-db-subnet-group') }
  it { should belong_to_subnet('subnet-8901b123') }
  it { should belong_to_subnet('db-subnet-a') }
  it { should have_db_parameter_group('default.mysql5.6') }
  it { should have_option_group('default:mysql-5-6') }
  it { should have_tag('Name').value('my-rds') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('db_subnet_group.db_subnet_group_name') { should eq 'my-db-subnet-group' }
  end
end
