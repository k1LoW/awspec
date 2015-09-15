### be_allowed_action

```ruby
describe iam_group('my-iam-group') do
  it { should be_allowed_action('ec2:DescribeInstances') }
  it { should be_allowed_action('s3:Put*').resource_arn('arn:aws:s3:::my-bucket-name/*') }
end
```
