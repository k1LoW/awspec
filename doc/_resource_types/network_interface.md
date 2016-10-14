### exist

```ruby
describe network_interface('eni-12ab3cde') do
  it { should exist }
end
```

### be_attached_to

```ruby
describe network_interface('eni-12ab3cde') do
  it { should be_attached_to('my-ec2') }
  it { should be_attached_to('my-ec2').as_eth0 }
end
```

### be_available, be_attaching, be_in_use, be_detaching

```ruby
describe network_interface('eni-12ab3cde') do
  it { should be_in_use }
end
```

### have_private_ip_address

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_private_ip_address('10.0.1.1').primary }
  it { should have_private_ip_address('10.0.1.2') }
  its(:private_ip_addresses_count) { should eq 2 }
end
```

### have_security_group

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_security_group('my-security-group-name') }
end
```

### have_tag

```ruby
describe network_interface('eni-12ab3cde') do
  it { should have_tag('Name').value('my-eni') }
end
```

### belong_to_subnet

```ruby
describe network_interface('eni-12ab3cde') do
  it { should belong_to_subnet('my-subnet') }
end
```

### belong_to_vpc

```ruby
describe network_interface('eni-12ab3cde') do
  it { should belong_to_vpc('my-vpc') }
end
```
