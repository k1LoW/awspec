### exist

ecs_container_instance need `cluster_name` ( default: `default` ).

```ruby
describe ecs_container_instance('my-container-instance'), cluster_name: 'my-ecs-cluster' do
  it { should exist }
end
```

### be_active, be_inactive

```ruby
describe ecs_container_instance('my-container-instance'), cluster_name: 'my-ecs-cluster' do
  it { should be_active }
end
```

