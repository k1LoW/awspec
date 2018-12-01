### exist

```ruby
describe vpc('my-vpc') do
  it { should exist }
end
```

### be_available, be_pending

```ruby
describe vpc('vpc-ab123cde') do
  it { should be_available }
end
```

### be_connected_to_vpc

```ruby
describe vpc('vpc-ab123cde') do
  it { should be_connected_to_vpc('vpc-bcd1235e') }
  it { should be_connected_to_vpc('vpc-bcd1235e').as_accepter }
  it { should_not be_connected_to_vpc('vpc-bcd1235e').as_requester }
end
```

### have_network_acl

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
end
```

### have_route_table

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_route_table('rtb-ab123cde') }
  it { should have_route_table('my-route-table') }
end
```

### have_tag

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_tag('Stack').value('Networking') }
end
```

### have_vpc_peering_connection

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_vpc_peering_connection('pcx-c56789de') }
  it { should have_vpc_peering_connection('pcx-c56789de').as_accepter }
  it { should_not have_vpc_peering_connection('pcx-c56789de').as_requester }
end
```

### have_vpc_attribute

```ruby
describe vpc('vpc-ab123cde') do
  it { should have_vpc_attribute('enableDnsHostnames') }
  it { should_not have_vpc_attribute('enableDnsSupport') }
end
```

### advanced

`vpc` can use `Aws::EC2::Vpc` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Vpc.html).

```ruby
describe vpc('my-vpc') do
  its('route_tables.first.route_table_id') { should eq 'rtb-a12bcd34' }
end
```

or

```ruby
describe vpc('my-vpc') do
  its('resource.route_tables.first.route_table_id') { should eq 'rtb-a12bcd34' }
end
```
