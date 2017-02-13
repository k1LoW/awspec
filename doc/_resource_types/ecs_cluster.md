### exist

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { should exist }
end
```

### be_active, be_inactive

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { should be_active }
end
```

### have_container_instance

```ruby
describe ecs_cluster('my-ecs-cluster') do
  it { have_container_instance('f2756532-8f13-4d53-87c9-aed50dc94cd7') }
end
```
