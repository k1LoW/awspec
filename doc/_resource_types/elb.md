### have_listener

http://docs.aws.amazon.com/en_us/ElasticLoadBalancing/latest/DeveloperGuide/elb-listener-config.html

```ruby
describe elb('my-elb') do
  it { should have_listener(protocol: 'HTTPS', port: 443, instance_protocol: 'HTTP', instance_port: 80) }
end
```
