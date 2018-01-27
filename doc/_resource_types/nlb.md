### exist

```ruby
describe nlb('my-nlb') do
  it { should exist }
end
```

### be_active, be_provisioning, be_failed

```ruby
describe nlb('my-nlb') do
  it { should be_active }
end
```

### have_security_group

```ruby
describe nlb('my-nlb') do
  it { should have_security_group('sg-1a2b3cd4') }
end
```

### have_subnet

```ruby
describe nlb('my-nlb') do
  it { should have_subnet('subnet-1234a567') }
end
```

### belong_to_vpc

```ruby
describe nlb('my-nlb') do
  it { should belong_to_vpc('my-vpc') }
end
```
