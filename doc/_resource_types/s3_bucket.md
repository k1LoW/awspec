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

### have_cors_rule

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_cors_rule(
      allowed_methods: ['GET'],
      allowed_origins: ['*']
    )
  end
  it do
    should have_cors_rule(
      allowed_headers: ['*'],
      allowed_methods: ['GET'],
      allowed_origins: ['https://example.org', 'https://example.com'],
      expose_headers:  ['X-Custom-Header'],
      max_age_seconds: 3600
    )
  end
end
```

### have_policy

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_policy <<-POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::my-bucket/*"
    }
  ]
}
    POLICY
  end
end
```

### have_object

```ruby
describe s3_bucket('my-bucket') do
  it { should have_object('path/to/object') }
end
```

### have_lifecycle_rule

```ruby
describe s3_bucket('my-bucket') do
  it do
    should have_lifecycle_rule(
      id: 'MyRuleName',
      noncurrent_version_expiration: { noncurrent_days: 1 },
      expiration: { days: 2 },
      transitions: [{ days: 3, storage_class: 'GLACIER' }],
      status: 'Enabled'
    )
  end

  it do
    should have_lifecycle_rule(
      id: 'MyRuleName2',
      prefix: '123/',
      noncurrent_version_expiration: { noncurrent_days: 2 },
      expiration: { days: 3 },
      transitions: [{ days: 5, storage_class: 'STANDARD_IA' }, { days: 10, storage_class: 'GLACIER' }],
      status: 'Enabled'
    )
  end
end
```

### have_logging_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_logging_enabled(target_bucket: 'my-log-bucket', target_prefix: 'logs/') }
end
```

### have_tag

```ruby
describe s3_bucket('my-bucket') do
  it { should have_tag('env').value('dev') }
end
```

### have_versioning_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_versioning_enabled }
end
```

### have_mfa_delete_enabled

```ruby
describe s3_bucket('my-bucket') do
  it { should have_mfa_delete_enabled }
end
```

### have_server_side_encryption

```
describe s3_bucket('my-bucket') do
  it { should have_server_side_encryption(algorithm: "AES256") }
  it { should have_server_side_encryption(algorithm: "aws:kms") }
end
```

### advanced

`s3_bucket` can use `Aws::S3::Bucket` resource (see http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Bucket.html).

```ruby
describe s3_bucket('my-bucket') do
  its('acl.owner.display_name') { should eq 'my-bucket-owner' }
end
```

or

```ruby
describe s3_bucket('my-bucket') do
  its('resource.acl.owner.display_name') { should eq 'my-bucket-owner' }
end
```
