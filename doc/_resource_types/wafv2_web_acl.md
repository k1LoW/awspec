### exist

You can set `scope` to CLOUDFRONT or REGIONAL ( default: `REGIONAL` ).

```ruby
describe wafv2_web_acl('my-wafv2-web-acl'), scope: 'REGIONAL' do
  it { should exist }
  its(:default_action) { should eq 'ALLOW' }
end

describe wafv2_web_acl('my-wafv2-web-acl'), scope: 'CLOUDFRONT', region: 'us-east-1' do
  it { should exist }
  its(:default_action) { should eq 'ALLOW' }
end
```

### have_rule

```ruby
describe wafv2_web_acl('my-wafv2-web-acl'), scope: 'REGIONAL' do
  it { should have_rule('AWS-AWSManagedRulesCommonRuleSet') }
  it { should have_rule('AWS-AWSManagedRulesKnownBadInputsRuleSet').order(1) }
  it { should have_rule('AWS-AWSManagedRulesLinuxRuleSet').order(2).override_action('NONE') }
end
```
