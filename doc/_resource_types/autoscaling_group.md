### exist

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should exist }
end
```

### have_ec2

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_ec2('my-ec2') }
end
```

### have_elb

```ruby
describe autoscaling_group('my-auto-scaling-group') do
  it { should have_elb('my-elb') }
end
```
