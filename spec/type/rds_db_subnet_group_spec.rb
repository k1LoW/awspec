# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'rds_db_subnet_group'

describe rds_db_subnet_group('my-rds-db-subnet-group') do
  it { should exist }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('db-subnet-a') }
end
