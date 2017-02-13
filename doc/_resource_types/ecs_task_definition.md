### exist

```ruby
describe ecs_task_definition('my-ecs-task-definition') do
  it { should exist }
end
```

### be_active, be_inactive

```ruby
describe ecs_task_definition('my-ecs-task-definition') do
  it { should be_active }
end
```
