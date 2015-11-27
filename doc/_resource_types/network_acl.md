### exist

```ruby
describe network_acl('my-network-acl') do
  it { should exist }
end
```

### have_subnet

```ruby
describe network_acl('my-network-acl') do
  it { should have_subnet('my-subnet') }
end
```

### belong_to_vpc

```ruby
describe network_acl('my-network-acl') do
  it { should belong_to_vpc('my-vpc') }
end
```

### its(:inbound), its(:outbound), its(:inbound_entries_count), its(:outbound_entries_count)

```ruby
describe network_acl('my-network-acl') do
  its(:inbound) { should be_allowed(80).protocol('tcp').source('123.0.456.789/32') }
  its(:inbound) { should be_denied.rule_number('*').source('0.0.0.0/0') }
  its(:outbound) { should be_allowed.protocol('ALL').source('0.0.0.0/0') }
  its(:inbound_entries_count) { should eq 3 }
  its(:outbound_entries_count) { should eq 2 }
end
```
