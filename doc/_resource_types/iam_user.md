### exist

```ruby
describe iam_user('my-iam-user') do
  it { should exist }
end
```

### be_allowed_action

```ruby
describe iam_user('my-iam-user') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```

### have_iam_policy

```ruby
describe iam_user('my-iam-user') do
  it { should have_iam_policy('ReadOnlyAccess') }
end
```

### belong_to_iam_group

```ruby
describe iam_user('my-iam-user') do
  it { should belong_to_iam_group('my-iam-group') }
end
```
