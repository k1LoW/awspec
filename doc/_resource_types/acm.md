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

### advanced

`acm` can use `Aws::ACM::Types::CertificateDetail` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/ACM/Types/CertificateDetail.html).

```ruby
describe acm('example.com') do
  its(:type) { should eq 'AMAZON_ISSUED' }
end
```

or

```ruby
describe acm('example.com') do
  its('type') { should eq 'AMAZON_ISSUED' }
end
```
