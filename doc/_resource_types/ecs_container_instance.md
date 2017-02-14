### exist

You can set `cluster` ( default: `default` ).

```ruby
describe ecs_container_instance('my-container-instance'), cluster: 'my-ecs-cluster' do
  it { should exist }
end
```

### be_active, be_inactive

```ruby
describe ecs_container_instance('my-container-instance'), cluster: 'my-ecs-cluster' do
  it { should be_active }
end
```

