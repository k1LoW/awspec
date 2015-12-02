Aws.config[:s3] = {
  stub_responses: {
    list_buckets: {
      buckets: [
        {
          name: 'my-bucket'
        }
      ]
    },
    head_object: {
      content_type: 'binary/octet-stream'
    },
    get_bucket_acl: {
      owner: {
        display_name: 'my-bucket-owner'
      },
      grants: [
        {
          grantee: {
            display_name: 'my-bucket-owner',
            type: 'CanonicalUser'
          },
          permission: 'FULL_CONTROL'
        },
        {
          grantee: {
            display_name: 'my-bucket-write-only',
            type: 'CanonicalUser'
          },
          permission: 'WRITE'
        },
        {
          grantee: {
            display_name: 'my-bucket-read-only',
            type: 'CanonicalUser'
          },
          permission: 'READ'
        }
      ]
    },
    get_bucket_policy: {
      policy: <<-POLICY
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
    }
  }
}
