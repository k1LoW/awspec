### exist

```ruby
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should exist }
  its(:port) { should eq 80 }
  its(:protocol) { should eq 'HTTP' }
end
```

### have_rule

```ruby
describe alb_listener('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2') do
  it { should have_rule('arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:listener-rule/app/my-alb/1aa1bb1cc1ddee11/f2f7dc8efc522ab2/9683b2d02a6cabee') }
  it do
    should have_rule.priority('10')
      .conditions(field: 'path-pattern', values: ['/img/*'])
      .actions(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it do
    should have_rule.priority('10')
      .if(field: 'path-pattern', values: ['/img/*'])
      .then(target_group_arn: 'arn:aws:elasticloadbalancing:ap-northeast-1:1234567890:123456789012:targetgroup/73e2d6bc24d8a067/73e2d6bc24d8a067', type: 'forward')
  end
  it { should have_rule.conditions([{ field: 'path-pattern', values: ['/admin/*'] }, { field: 'host-header', values: ['admin.example.com'] }]) }
  it { should have_rule.actions(target_group_name: 'my-alb-target-group', type: 'forward') }
end
```
