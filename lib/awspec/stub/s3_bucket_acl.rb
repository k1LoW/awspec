Aws.config[:s3] = {
  stub_responses: {
    get_bucket_acl: {
      owner: {
        display_name: 'owner'
      },
      grants: [
      ]
    }
  }
}
