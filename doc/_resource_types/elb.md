### exist

```ruby
describe elb('my-elb') do
  it { should exist }
end
```

### have_ec2

```ruby
describe elb('my-elb') do
  it { should have_ec2('my-ec2') }
end
```

### have_listener

http://docs.aws.amazon.com/en_us/ElasticLoadBalancing/latest/DeveloperGuide/elb-listener-config.html

```ruby
describe elb('my-elb') do
  it { should have_listener(protocol: 'HTTPS', port: 443, instance_protocol: 'HTTP', instance_port: 80) }
end
```

### have_security_group

```ruby
describe elb('my-elb') do
  it { should have_security_group('my-lb-security-group-tag-name') }
end
```

### have_subnet

```ruby
describe elb('my-elb') do
  it { should have_subnet('my-subnet') }
end
```

### belong_to_vpc

```ruby
describe elb('my-elb') do
  it { should belong_to_vpc('my-vpc') }
end
```

### have_tag

```ruby
describe elb('my-elb') do
  it { should have_tag('Name').value('my-elb') }
  it { should have_tag('my-tag-key').value('my-tag-value') }
end
```

### be_cross_zone_load_balancing_enabled

```ruby
describe elb('my-elb') do
  it { should be_cross_zone_load_balancing_enabled }
end
```

### have_access_log

```ruby
describe elb('my-elb') do
  it { should have_access_log(s3_bucket_name: 'my-loadbalancer-logs', s3_bucket_prefix: 'my-app', emit_interval: 5) }
end
```

### have_connection_draining

```ruby
describe elb('my-elb') do
  it { should have_connection_draining(timeout: 300) }
end
```
