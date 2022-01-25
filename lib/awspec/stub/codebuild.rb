# frozen_string_literal: true

Aws.config[:codebuild] = {
  stub_responses: {
    list_projects: {
      projects: %w[
        my-codebuild1
        my-codebuild2
      ]
    }
  }
}
