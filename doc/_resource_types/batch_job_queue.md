### exist

```ruby
describe batch_job_queue('my-batch-job-queue') do
  it { should exist }
end
```

### be_enabled, be_disabled

```ruby
describe batch_job_queue('my-batch-job-queue') do
  it { should be_enabled }
end
```

### have_compute_environment_order

```ruby
describe batch_job_queue('my-batch-job-queue') do
  it { should have_compute_environment_order('arn:aws:batch:us-east-1:012345678910:compute-environment/C4OnDemand', 1) }
end
```
