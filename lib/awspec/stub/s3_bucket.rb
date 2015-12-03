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
            uri: 'http://acs.amazonaws.com/groups/s3/LogDelivery',
            type: 'CanonicalUser'
          },
          permission: 'WRITE'
        },
        {
          grantee: {
            id: '68f4bb06b094152df53893bfba57760e',
            type: 'CanonicalUser'
          },
          permission: 'READ'
        }
      ]
    },
    get_bucket_cors: {
      cors_rules: [
        {
          allowed_methods: ['GET'],
          allowed_origins: ['*']
        },
        {
          allowed_headers: ['*'],
          allowed_methods: ['GET'],
          allowed_origins: ['https://example.com', 'https://example.org'],
          expose_headers:  ['X-Custom-Header'],
          max_age_seconds: 3600
        }
      ]
    },
    get_bucket_policy: {
      policy: '{"Version":"2012-10-17","Statement":' \
              '[{"Sid":"AllowPublicRead","Effect":"Allow",' \
              '"Principal":"*","Action":"s3:GetObject",' \
              '"Resource":"arn:aws:s3:::my-bucket/*"}]}'
    }
  }
}
