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
      policy: '{"Version":"2012-10-17","Statement":[{"Sid":"","Effect":"Allow","Principal":' \
              '{"AWS":"arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity XXXXX"},' \
              '"Action":"s3:*","Resource":["arn:aws:s3:::my-bucket","arn:aws:s3:::my-bucket/*"]}]}'
    },
    get_bucket_logging: {
      logging_enabled: {
        target_bucket: 'my-log-bucket',
        target_prefix: 'logs/'
      }
    },
    get_bucket_versioning: {
      status: 'Enabled',
      mfa_delete: 'Enabled'
    },
    get_bucket_tagging: {
      tag_set: [
        {
          key: 'env',
          value: 'dev'
        }
      ]
    },
    get_bucket_lifecycle_configuration: {
      rules: [
        {
          id: 'MyRuleName',
          status: 'Enabled',
          transitions: [
            {
              days: 3,
              storage_class: 'GLACIER'
            }
          ],
          expiration: {
            days: 2
          },
          noncurrent_version_expiration: {
            noncurrent_days: 1
          }
        },
        {
          id: 'MyRuleName2',
          filter: {
            prefix: '123/'
          },
          status: 'Enabled',
          transitions: [
            {
              days: 5,
              storage_class: 'STANDARD_IA'
            },
            {
              days: 10,
              storage_class: 'GLACIER'
            }
          ],
          expiration: {
            days: 3
          },
          noncurrent_version_expiration: {
            noncurrent_days: 2
          }
        }
      ]
    },
    get_bucket_encryption: {
      server_side_encryption_configuration: {
        rules: [
          {
            apply_server_side_encryption_by_default: {
              sse_algorithm: 'aws:kms',
              kms_master_key_id: '[FILTERED]'
            }
          }
        ]
      }
    }
  }
}
