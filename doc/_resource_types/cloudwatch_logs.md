### exist

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should exist }
end
```

### have_log_stream

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_log_stream('my-cloudwatch-logs-stream') }
end
```

### have_metric_filter

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_metric_filter('my-cloudwatch-logs-metric-filter') }
end
```

### have_subscription_filter

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_subscription_filter('my-cloudwatch-logs-subscription-filter') }
end
```
or
```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it do
    should have_subscription_filter('my-cloudwatch-logs-subscription-filter')\
      .filter_pattern('[host, ident, authuser, date, request, status, bytes]')
  end
end
```

### have_tag

```ruby
describe cloudwatch_logs('my-cloudwatch-logs-group') do
  it { should have_tag('Name').value('my-cloudwatch-logs-group') }
end
```
