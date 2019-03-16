### exist

```ruby
describe wafregional_web_acl('my-wafregional-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-wafregional-web-acl-allowed-ips') }
  it { should have_rule('my-wafregional-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```

### have_rule

```ruby
describe wafregional_web_acl('my-wafregional-web-acl') do
  it { should have_rule('my-wafregional-web-acl-allowed-ips') }
  it { should have_rule('my-wafregional-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```

### its(:default_action), its(:web_acl_id), its(:name), its(:metric_name)

```ruby
describe wafregional_web_acl('my-wafregional-web-acl') do
  its(:default_action) { should eq 'BLOCK' }
end
```


