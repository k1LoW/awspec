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

### have_inline_policy

```ruby
describe iam_user('my-iam-user') do
  it { should have_inline_policy('AllowS3BucketAccess') }
  it do
    should have_inline_policy('AllowS3BucketAccess').policy_document(<<-'DOC')
{
"Statement": [
    {
     "Action": [
        "s3:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::*"
    },
    {
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": ["arn:aws:s3:::my-bucket", "arn:aws:s3:::my-bucket/*"]
    }
  ]
}
DOC
  end
end
```

You can test absence of inline policies.

```ruby
describe iam_user('my-iam-user') do
  it { should_not have_inline_policy }
end
```

### belong_to_iam_group

```ruby
describe iam_user('my-iam-user') do
  it { should belong_to_iam_group('my-iam-group') }
end
```

### advanced

`iam_user` can use `Aws::IAM::User` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/IAM/User.html).

```ruby
describe iam_user('my-iam-user') do
  its('login_profile.password_reset_required') { should eq false }
end
```

or

```ruby
describe iam_user('my-iam-user') do
  its('resource.login_profile.password_reset_required') { should eq false }
end
```
