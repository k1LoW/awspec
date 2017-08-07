### exist

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should exist }
  its(:health_check_path) { should eq '/' }
  its(:health_check_port) { should eq 'traffic-port' }
  its(:health_check_protocol) { should eq 'HTTP' }
end
```

### have_ec2

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should have_ec2('my-ec2') }
end
```

### belong_to_alb

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should belong_to_alb('my-alb') }
end
```

### belong_to_vpc

```ruby
describe alb_target_group('my-alb-target-group') do
  it { should belong_to_vpc('my-vpc') }
end
```

