require 'spec_helper'

Aws.config[:ec2] = {
  stub_responses: {
    describe_instances: {
      reservations: [
        {
          instances: [
            {
              instance_id: 'i-ec12345a',
              image_id: 'ami-abc12def',
              vpc_id: 'vpc-ab123cde',
              subnet_id: 'subnet-1234a567',
              public_ip_address: '123.0.456.789',
              instance_type: 't2.small',
              state: {
                name: 'running'
              },
              security_groups: [
                {
                  group_id: 'sg-1a2b3cd4',
                  group_name: 'my-security-group-name'
                }
              ],
              tags: [
                {
                  key: 'Name',
                  value: 'my-ec2'
                }
              ]
            }
          ]
        }
      ]
    },
    describe_vpcs: {
      vpcs: [
        {
          vpc_id: 'vpc-ab123cde',
          tags: [
            {
              key: 'Name',
              value: 'my-vpc'
            }
          ]
        }
      ]
    },
    describe_subnets: {
      subnets: [
        {
          vpc_id: 'vpc-ab123cde',
          subnet_id: 'subnet-1234a567',
          tags: [
            {
              key: 'Name',
              value: 'my-subnet'
            }
          ]
        }
      ]
    },
    describe_addresses: {
      addresses: [
        {
          public_ip: '123.0.456.789',
          instance_id: 'i-ec12345a'
        }
      ]
    },
    describe_security_groups: {
      security_groups: [
        {
          group_id: 'sg-1a2b3cd4',
          group_name: 'my-security-group-name',
          tags: [
            {
              key: 'Name',
              value: 'my-security-group-tag-name'
            }
          ]
        }
      ]
    }
  }
}

describe ec2('i-ec12345a') do
  it { should be_running }
  it { should_not be_stopped }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  it { should have_security_group('sg-1a2b3cd4') }
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('my-security-group-tag-name') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('my-subnet') }
  it { should have_eip }
  it { should have_eip('123.0.456.789') }
end

describe ec2({ :'tag:Name' => 'my-ec2' }) do
  it { should be_running }
  it { should_not be_stopped }
  its(:instance_id) { should eq 'i-ec12345a' }
  its(:image_id) { should eq 'ami-abc12def' }
  its(:public_ip_address) { should eq '123.0.456.789' }
  it { should have_security_group('sg-1a2b3cd4') }
  it { should have_security_group('my-security-group-name') }
  it { should have_security_group('my-security-group-tag-name') }
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
  it { should belong_to_subnet('subnet-1234a567') }
  it { should belong_to_subnet('my-subnet') }
  it { should have_eip }
  it { should have_eip('123.0.456.789') }
end