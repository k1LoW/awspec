### exist

```ruby
describe sqs('my-queue') do
  it { should exist }
  its(:queue_arn) { should eq 'arn:aws:sqs:ap-northeast-1:123456789012:my-queue' }
end
```
