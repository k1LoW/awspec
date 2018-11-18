### exist

```ruby
describe acm('example.com') do
  it { should exist }
end
```

### be_issued

```ruby
describe acm('example.com') do
  it { should be_issued }
end
```

### have_domain_validation_option

```ruby
describe acm('example.com') do
  it { should have_domain_validation_option(domain_name: 'example.com', validation_method: 'DNS', validation_status: 'SUCCESS') }
  it { should have_domain_validation_option(domain_name: 'mail.example.com', validation_method: 'EMAIL') }
end
```
