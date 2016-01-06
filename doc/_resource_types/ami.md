### exist

```ruby
describe ami('my-ami') do
  it { should exist }
end
```

### be_pending, be_available, be_invalid, be_deregistered, be_transient, be_failed, be_error

```ruby
describe ami('my-ami') do
  it { should be_available }
end
```

### advanced

`ami` can use `Aws::EC2::Image` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Image.html).
