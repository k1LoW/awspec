require 'spec_helper'

Aws.config[:ec2] = {
  stub_responses: {
    describe_vpcs: {
      vpcs: [
        {
          vpc_id: 'vpc-ab123cde',
          state: 'available',
          tags: [
            {
              key: 'Name',
              value: 'my-vpc'
            }
          ]
        }
      ]
    },
    describe_route_tables: {
      route_tables: [
        {
          route_table_id: 'rtb-a12bcd34',
          vpc_id: 'vpc-ab123cde',
          tags: [
            {
              key: 'Name',
              value: 'my-route-table'
            }
          ]
        }
      ]
    },
    describe_network_acls: {
      network_acls: [
        {
          network_acl_id: 'acl-1abc2d3e',
          vpc_id: 'vpc-ab123cde',
          tags: [
            {
              key: 'Name',
              value: 'my-network-acl'
            }
          ]
        }
      ]
    }
  }
}

describe vpc('vpc-ab123cde') do
  it { should be_available }
  it { should have_route_table('rtb-a12bcd34') }
  it { should have_route_table('my-route-table') }
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
end

describe vpc('my-vpc') do
  it { should be_available }
  it { should have_route_table('rtb-a12bcd34') }
  it { should have_route_table('my-route-table') }
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
end
