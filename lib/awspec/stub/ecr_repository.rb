Aws.config[:ecr] = {
  stub_responses: {
    describe_repositories: {
      repositories: [
        {
          registry_id: '123456789012',
          repository_arn: 'arn:aws:ecr:us-east-1:123456789012:repository/my-ecr-repository',
          repository_name: 'my-ecr-repository'
        }
      ]
    }
  }
}
