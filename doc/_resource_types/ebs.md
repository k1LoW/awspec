### exist

```ruby
describe ebs('my-volume') do
  it { should exist }
end
```

### be_attached_to

```ruby
describe ebs('my-volume') do
  it { should be_attached_to('my-ec2') }
end
```

### be_creating, be_available, be_in_use, be_deleting, be_deleted, be_error

```ruby
describe ebs('my-volume') do
  it { should be_in_use }
end
```
