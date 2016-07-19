### exist

```ruby
describe cloudtrail('my-trail') do
  it { should exist }
end
```

### have_global_service_events_included

```ruby
describe cloudtrail('my-trail') do
  it { should have_global_service_events_included }
end
```

### be_multi_region_trail

```ruby
describe cloudtrail('my-trail') do
  it { should be_multi_region_trail }
end
```

### have_log_file_validation_enabled

```ruby
describe cloudtrail('my-trail') do
  it { should have_log_file_validation_enabled }
end
```
