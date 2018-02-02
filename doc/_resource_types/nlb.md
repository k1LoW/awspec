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

Note that NLBs never have security groups. The have_security_group() function always returns false. See https://forums.aws.amazon.com/thread.jspa?threadID=263245 for discussion about the security-group-less-ness of NLBs.

```ruby
describe nlb('my-nlb') do
  it { should_not have_security_group('sg-1a2b3cd4') }
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
