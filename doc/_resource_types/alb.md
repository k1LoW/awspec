### exist

```ruby
describe alb('my-alb') do
  it { should exist }
end
```

### be_active, be_provisioning, be_failed

```ruby
describe alb('my-alb') do
  it { should be_active }
end
```

### have_security_group

```ruby
describe alb('my-alb') do
  it { should have_security_group('sg-1a2b3cd4') }
end
```


