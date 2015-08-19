### exist

In order to test a EC2 instance exists, you should use **exist** matcher.

```ruby
describe ec2('my-ec2') do
  it { should exist }
end
```

### be_running

In order to test a EC2 instance is running, you should use **be_running** matcher.

```ruby
describe ec2('my-ec2') do
  it { should be_running }
end
```
