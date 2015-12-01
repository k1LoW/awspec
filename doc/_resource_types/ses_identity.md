### exist

```ruby
describe ses_identity('example.com') do
  it { should exist }
end
```

### have_dkim_tokens

### have_identity_policy

```ruby
describe ses_identity('example.com') do
  it { should have_identity_policy('my-identity-policy-name') }
end
```
