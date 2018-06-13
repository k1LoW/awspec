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

### have_source_type

```ruby
describe firehose('my-firehose') do
  it { should have_source_type('DirectPut') }
end
```

### have_splunk_destination

```ruby
describe firehose('my-firehose') do
  it { should have_splunk_destination }
end
```
