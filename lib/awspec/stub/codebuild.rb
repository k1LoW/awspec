# frozen_string_literal: true

Aws.config[:codebuild] = {
  stub_responses: {
    batch_get_projects: {
      projects: [
        {
          name: 'my-codebuild1',
          arn: 'arn:aws:codebuild:ap-northeast-1:123456789012:project/my-codebuild1',
          source: {
            type: 'S3',
            location: 'example-bucket/test.zip',
            insecure_ssl: false
          },
          secondary_sources: [],
          secondary_source_versions: [],
          artifacts: {
            type: 'NO_ARTIFACTS'
          },
          secondary_artifacts: [],
          cache: {
            type: 'NO_CACHE'
          },
          environment: {
            type: 'LINUX_CONTAINER',
            image: 'aws/codebuild/amazonlinux2-x86_64-standard:5.0',
            compute_type: 'BUILD_GENERAL1_SMALL',
            environment_variables: [],
            privileged_mode: false,
            image_pull_credentials_type: 'CODEBUILD'
          },
          service_role: 'arn:aws:iam::123456789012:role/service-role/codebuild-my-codebuild1-service-role',
          timeout_in_minutes: 60,
          queued_timeout_in_minutes: 480,
          encryption_key: 'arn:aws:kms:ap-northeast-1:123456789012:alias/aws/s3',
          tags: [
            {
              key: 'env',
              value: 'dev'
            }
          ],
          created: Time.local(2024),
          last_modified: Time.local(2024),
          badge: {
            badge_enabled: false
          },
          logs_config: {
            cloud_watch_logs: {
              status: 'ENABLED'
            },
            s3_logs: {
              status: 'DISABLED',
              encryption_disabled: false
            }
          },
          project_visibility: 'PRIVATE'
        }
      ],
      projects_not_found: []
    },
    list_projects: {
      projects: %w[
        my-codebuild1
        my-codebuild2
      ]
    }
  }
}
