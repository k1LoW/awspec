require 'spec_helper'
Awspec::Stub.load 'dynamodb_table'

describe dynamodb_table('my-dynamodb-table') do
  it { should exist }
  it { should be_active }
  its('provisioned_throughput.read_capacity_units') { should eq 1 }
  its('provisioned_throughput.write_capacity_units') { should eq 1 }
  it { should have_attribute_definition('my-dynamodb-table-attaribute1').attribute_type('S') }
  it { should have_attribute_definition('my-dynamodb-table-attaribute2').attribute_type('N') }
  it { should have_key_schema('my-dynamodb-table-key_schema1').key_type('HASH') }
  it { should have_key_schema('my-dynamodb-table-key_schema2').key_type('RANGE') }
  context 'nested attribute call' do
    its(:resource) { should be_an_instance_of(Awspec::ResourceReader) }
    its('resource.name') { should eq 'my-dynamodb-table' }
    its('provisioned_throughput.read_capacity_units') { should eq 1 }
    its('provisioned_throughput.write_capacity_units') { should eq 1 }
  end
end
