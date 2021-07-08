### exist

You can set `cluster` ( default: `default` ).

```ruby
describe ecs_service('my-ecs-service'), cluster: 'my-ecs-cluster' do
  it { should exist }
end
```

### be_active, be_draining, be_inactive

```ruby
describe ecs_service('my-ecs-service'), cluster: 'my-ecs-cluster' do
  it { should be_active }
end
```
