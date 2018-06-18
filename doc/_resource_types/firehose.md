### exist

```ruby
describe firehose('my-firehose') do
  it { should exist }
end
```

### be_active

```ruby
describe firehose('my-firehose') do
  it { should be_active }
end
```

### have_splunk_destination

```ruby
describe firehose('my-firehose') do
  it { should have_splunk_destination }
end
```

### advanced

```ruby
describe firehose('my-firehose') do
  its(:delivery_stream_type) { should be_eql('DirectPut') }
end
```
