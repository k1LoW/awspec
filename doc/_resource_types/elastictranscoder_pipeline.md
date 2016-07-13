# exist

```ruby
describe elastictranscoder_pipeline('my-elastictranscoder-pipeline') do
  it { should exist }
end
```

### be_active, be_paused

```ruby
describe elastictranscoder_pipeline('my-elastictranscoder-pipeline') do
  it { should be_active }
end
```
