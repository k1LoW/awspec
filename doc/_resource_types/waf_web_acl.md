### exist

```ruby
describe waf_web_acl('my-waf-web-acl') do
  it { should exist }
  its(:default_action) { should eq 'BLOCK' }
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```

### have_rule

```ruby
describe waf_web_acl('my-waf-web-acl') do
  it { should have_rule('my-waf-web-acl-allowed-ips') }
  it { should have_rule('my-waf-web-acl-allowed-ips').order(2).action('BLOCK') }
end
```

### its(:default_action), its(:web_acl_id), its(:name), its(:metric_name)

```ruby
describe waf_web_acl('my-waf-web-acl') do
  its(:default_action) { should eq 'BLOCK' }
end
```


