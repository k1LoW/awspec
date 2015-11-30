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
            display_name: 'my-bucket-grantee',
            type: 'CanonicalUser'
          },
          permission: 'FULL_CONTROL'
        }
      ]
    }
  }
}
