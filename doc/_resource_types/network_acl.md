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

### have_tag

```ruby
describe network_acl('my-network-acl') do
  it { should have_tag('Name').value('my-network-acl') }
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

### advanced

`network_acl` can use `Aws::EC2::NetworkAcl` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/NetworkAcl.html).

```ruby
describe network_acl('my-network-acl') do
  its('vpc.id') { should eq 'vpc-ab123cde' }
end
```

or

```ruby
describe network_acl('my-network-acl') do
  its('resource.vpc.id') { should eq 'vpc-ab123cde' }
end
```
