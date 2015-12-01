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
end
```

### have_subnet

```ruby
describe route_table('my-route-table') do
  it { should have_subnet('my-subnet') }
end
```
