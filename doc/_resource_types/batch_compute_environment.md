### exist

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should exist }
end
```

### be_enabled, be_disabled

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should be_enabled }
end
```

### be_managed, be_unmanaged

```ruby
describe batch_compute_environment('my-batch-compute-environment') do
  it { should be_managed }
end
```
