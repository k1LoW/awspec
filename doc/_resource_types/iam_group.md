### exist

```ruby
describe iam_group('my-iam-group') do
  it { should exist }
end
```

### be_allowed_action

```ruby
describe iam_group('my-iam-group') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```

### have_iam_policy

```ruby
describe iam_group('my-iam-group') do
  it { should have_iam_policy('ReadOnlyAccess') }
end
```

### have_iam_user

```ruby
describe iam_group('my-iam-group') do
  it { should have_iam_user('my-iam-user') }
end
```

### have_inline_policy

```ruby
describe iam_group('my-iam-group') do
  it { should have_inline_policy('InlineEC2FullAccess') }
  it do
    should have_inline_policy('InlineEC2FullAccess').policy_document(<<-'DOC')
{
  "Statement": [
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    }
  ]
}
DOC
  end
end
```

You can test absence of inline policies.

```ruby
describe iam_group('my-iam-group') do
  it { should_not have_inline_policy }
end
```

### advanced

`iam_group` can use `Aws::IAM::Group` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/Group.html).

```ruby
describe iam_group('my-iam-group') do
  its('users.count') { should eq 5 }
end
```

or

```ruby
describe iam_group('my-iam-group') do
  its('resource.users.count') { should eq 5 }
end
```
