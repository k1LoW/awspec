Aws.config[:s3] = {
  stub_responses: {
    get_bucket_acl: {
      owner: {
        display_name: 'owner'
      },
      grants: [
        {
          grantee: {
            display_name: 'grantee',
            type: 'CanonicalUser'
          },
          permission: 'FULL_CONTROL'
        }
      ]
    }
  }
}
