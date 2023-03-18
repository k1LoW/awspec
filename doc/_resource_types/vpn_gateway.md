### exist

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should exist }
end
```

### be_pending, be_available, be_deleting, be_deleted

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should be_running }
end
```

### have_tag

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should have_tag('Name').value('my-vpn-gateway') }
end
```

### belong_to_vpc

```ruby
describe vpn_gateway('my-vpn-gateway') do
  it { should belong_to_vpc('vpc-ab123cde') }
  it { should belong_to_vpc('my-vpc') }
end
```
