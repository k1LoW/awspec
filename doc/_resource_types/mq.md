### exist

```ruby
describe mq('my-mq') do
  it { should exist }
end
```

### be_running, be_reboot_in_progress, be_creation_in_progress, be_creation_failed, be_deletion_in_progress

```ruby
describe mq('my-mq') do
  it { should be_running }
end
```

### have_security_group

```ruby
describe mq('my-mq') do
  it { should have_security_group('sg-788eab237e47f1472') }
  it { should have_security_group('mq-group-name-sg') }
  it { should have_security_group('my-mq-sg') }
end
```

### have_tag

```ruby
describe mq('my-mq') do
  it { should have_tag('Name').value('my-mq') }
end
```
