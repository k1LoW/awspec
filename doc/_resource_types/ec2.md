### exist

```ruby
describe ec2('my-ec2') do
  it { should exist }
end
```

### be_running

```ruby
describe ec2('my-ec2') do
  it { should be_running }
end
```
