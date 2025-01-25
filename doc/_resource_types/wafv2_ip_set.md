### exist

You can set `scope` to CLOUDFRONT or REGIONAL ( default: `REGIONAL` ).

```ruby
describe wafv2_ip_set('my-ip-set'), scope: 'REGIONAL' do
  it { should exist }
end
```

### have_ip_address

```ruby
describe wafv2_ip_set('my-ip-set'), scope: 'REGIONAL' do
  it { should have_ip_address('10.0.0.0/32') }
end
```
