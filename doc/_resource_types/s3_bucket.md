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

### advanced

`s3_bucket` can delegate to `Aws::S3::Bucket` resource.

```ruby
describe s3_bucket('my-bucket') do
  its('acl.owner.display_name') { should eq 'my-bucket-owner' }
end
```

see http://docs.aws.amazon.com/sdkforruby/api/Aws/S3/Bucket.html .
