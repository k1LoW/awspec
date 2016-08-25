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

### have_tag

```ruby
describe ebs('my-volume') do
  it { should have_tag('Name').value('my-volume') }
end
```

### advanced

`ebs` can use `Aws::EC2::Volume` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Volume.html).

```ruby
describe ebs('my-volume') do
  its('attachments.first.instance_id') { should eq 'i-ec12345a' }
end
```

or

```ruby
describe ebs('my-volume') do
  its('resource.attachments.first.instance_id') { should eq 'i-ec12345a' }
end
```
