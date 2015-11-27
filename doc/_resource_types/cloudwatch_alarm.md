### exist

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should exist }
end
```

### have_alarm_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_alarm_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```

### have_insufficient_data_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_insufficient_data_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```

### have_ok_action

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should have_ok_action('arn:aws:sns:ap-northeast-1:1234567890:sns_alert') }
end
```

### belong_to_metric

```ruby
describe cloudwatch_alarm('my-cloudwatch-alarm') do
  it { should belong_to_metric('NumberOfProcesses').namespace('my-cloudwatch-namespace') }
end
```
