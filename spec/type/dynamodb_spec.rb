require 'spec_helper'
Awspec::Stub.load 'dynamodb'

describe dynamodb('my-dynamodb-table') do
  it { should exist }
  it { should be_active }
  its('provisioned_throughput.read_capacity_units') { should eq 1 }
  its('provisioned_throughput.write_capacity_units') { should eq 1 }
  it { should have_attribute_definition('my-dynamodb-table-attaribute1').attribute_type('S') }
  it { should have_attribute_definition('my-dynamodb-table-attaribute2').attribute_type('N') }
  it { should have_key_schema('my-dynamodb-table-key_schema1').key_type('HASH') }
  it { should have_key_schema('my-dynamodb-table-key_schema2').key_type('RANGE') }
end
