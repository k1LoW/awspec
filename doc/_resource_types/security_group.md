### exist

```ruby
describe security_group('my-security-group-name') do
  it { should exist }
end
```

### have_tag

```ruby
describe security_group('my-security-group-name') do
  it { should have_tag('env').value('dev') }
end
```

### its(:inbound), its(:outbound)

```ruby
describe security_group('my-security-group-name') do
  its(:outbound) { should be_opened }
  its(:inbound) { should be_opened(80) }
  its(:inbound) { should be_opened(80).protocol('tcp').for('203.0.113.1/32') }
  its(:inbound) { should be_opened(22).protocol('tcp').for('sg-5a6b7cd8') }
end
```

### advanced

`security_group` can use `Aws::EC2::SecurityGroup` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/SecurityGroup.html).

```ruby
describe security_group('my-security-group-name') do
  its('group_name') { should eq 'my-security-group-name' }
end
```

or

```ruby
describe security_group('my-security-group-name') do
  its('resource.group_name') { should eq 'my-security-group-name' }
end
```
