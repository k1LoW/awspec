Aws.config[:codebuild] = {
  stub_responses: {
    list_projects: {
      projects: [
        'my-codebuild1',
        'my-codebuild2'
      ]
    }
  }
}
