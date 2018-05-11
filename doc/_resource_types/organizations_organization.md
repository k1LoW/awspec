### exist

```ruby
describe organizations_organization('o-exampleorgid') do
  it { should exist }
end
```

### be_service_control_policy_enabled,be_service_control_policy_pending_enable,be_service_control_policy_pending_disable

```ruby
describe organizations_organization('o-exampleorgid') do
  it { should exist }
  it { should be_service_control_policy_enabled }
  it { should_not be_service_control_policy_pending_enable }
  it { should_not be_service_control_policy_pending_disable }
end
```
