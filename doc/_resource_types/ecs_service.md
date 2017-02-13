### exist

```ruby
describe ecs_service('my-ecs-service') do
  it { should exist }
end
```

### be_active, be_draining, be_inactive

```ruby
describe ecs_service('my-ecs-service') do
  it { should be_active }
end
```
