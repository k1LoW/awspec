### exist

```ruby
describe s3_bucket('my-bucket') do
  it { should exist }
end
```

### have_acl_grant

```ruby
describe s3_bucket('my-bucket') do
  its(:acl_owner) { should eq 'my-bucket-owner' }
  its(:acl_grants_count) { should eq 3 }
  it { should have_acl_grant(grantee: 'my-bucket-owner', permission: 'FULL_CONTROL') }
  it { should have_acl_grant(grantee: 'http://acs.amazonaws.com/groups/s3/LogDelivery', permission: 'WRITE') }
  it { should have_acl_grant(grantee: '68f4bb06b094152df53893bfba57760e', permission: 'READ') }
end
```

### have_object

```ruby
describe s3_bucket('my-bucket') do
  it { should have_object('path/to/object') }
end
```
