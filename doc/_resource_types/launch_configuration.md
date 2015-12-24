### exist

```ruby
describe launch_configuration('my-lc') do
  it { should exist }
end
```

### have_security_group

```ruby
describe launch_configuration('my-lc') do
  it { should have_security_group('my-security-group-name') }
end
```
