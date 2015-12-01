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
  it { should have_network_acl('acl-1abc2d3e') }
  it { should have_network_acl('my-network-acl') }
end
```
