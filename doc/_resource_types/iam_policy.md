### exist

```ruby
describe iam_policy('my-iam-policy') do
  it { should exist }
end
```

### be_attachable

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attachable }
end
```

### be_attached_to_group

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attached_to_group('my-iam-group') }
end
```

### be_attached_to_role

```ruby
describe iam_policy('my-iam-policy') do
  it { should be_attached_to_role('HelloIAmGodRole') }
end
```

### be_attached_to_user

```ruby
describe iam_policy('my-iam-user') do
  it { should be_attached_to_user('my-iam-user') }
end
```
