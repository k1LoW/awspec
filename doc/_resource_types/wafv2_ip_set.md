### exist

You can set `scope` to CLOUDFRONT or REGIONAL ( default: `REGIONAL` ).

```ruby
describe wafv2_ip_set('my-wafv2-ip-set'), scope: 'REGIONAL' do
  it { should exist }
end

describe wafv2_ip_set('my-wafv2-ip-set'), scope: 'CLOUDFRONT', region: 'us-east-1' do
  it { should exist }
end
```

### have_ip_address

```ruby
describe wafv2_ip_set('my-wafv2-ip-set'), scope: 'REGIONAL' do
  it { should have_ip_address('10.0.0.0/32') }
end
```
