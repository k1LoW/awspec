### exist

```ruby
describe route_table('my-route-table') do
  it { should exist }
end
```

### have_route

```ruby
describe route_table('my-route-table') do
  it { should have_route('10.0.0.0/16').target(gateway: 'local') }
  it { should have_route('0.0.0.0/0').target(gateway: 'igw-1ab2345c') }
  it { should have_route('192.168.1.0/24').target(instance: 'my-ec2') }
  it { should have_route('192.168.2.0/24').target(vpc_peering_connection: 'my-pcx') }
  it { should have_route('192.168.3.0/24').target(nat: 'nat-7ff7777f') }
end
```

### have_subnet

```ruby
describe route_table('my-route-table') do
  it { should have_subnet('my-subnet') }
end
```

### have_tag

```ruby
describe route_table('my-route-table') do
  it { should have_tag('Name').value('my-route-table') }
end
```

### route_count
```ruby
describe route_table('my-route-table') do
  its (:route_count) { should eq 10 }
end
```

### advanced

`route_table` can use `Aws::EC2::RouteTable` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/RouteTable.html).

```ruby
describe route_table('my-route-table') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe s3_bucket('my-bucket') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```
