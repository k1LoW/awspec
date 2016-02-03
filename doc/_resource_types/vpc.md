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
