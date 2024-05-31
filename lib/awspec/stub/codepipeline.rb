# frozen_string_literal: true

Aws.config[:codepipeline] = {
  stub_responses: {
    get_pipeline: {
      pipeline: {
        name: 'my-codepipeline',
        role_arn: 'arn:aws:iam::123456789012:role/service-role/AWSCodePipelineServiceRole-my-codepipeline',
        artifact_store: {
          type: 'S3',
          location: 'codepipeline-ap-northeast-1-12345678901'
        },
        stages: [
          {
            name: 'Source',
            actions: [
              {
                name: 'Source',
                action_type_id: {
                  category: 'Source',
                  owner: 'AWS',
                  provider: 'S3',
                  version: '1'
                },
                run_order: 1,
                configuration: {
                  'PollForSourceChanges' => 'false',
                  'S3Bucket' => 'example-bucket',
                  'S3ObjectKey' => 'test.zip'
                },
                output_artifacts: [
                  {
                    name: 'SourceArtifact'
                  }
                ],
                input_artifacts: [],
                region: 'ap-northeast-1',
                namespace: 'SourceVariables'
              }
            ]
          },
          {
            name: 'Build',
            actions: [
              {
                name: 'Build',
                action_type_id: {
                  category: 'Build',
                  owner: 'AWS',
                  provider: 'CodeBuild',
                  version: '1'
                },
                run_order: 1,
                configuration: {
                  'ProjectName' => 'my-codebuild1'
                },
                output_artifacts: [
                  {
                    name: 'BuildArtifact'
                  }
                ],
                input_artifacts: [
                  {
                    name: 'SourceArtifact'
                  }
                ],
                region: 'ap-northeast-1',
                namespace: 'BuildVariables'
              }
            ]
          }
        ],
        version: 1,
        execution_mode: 'QUEUED',
        pipeline_type: 'V2'
      },
      metadata: {
        pipeline_arn: 'arn:aws:codepipeline:ap-northeast-1:123456789012:my-codepipeline',
        created: Time.local(2024),
        updated: Time.local(2024)
      }
    },
    list_pipelines: {
      pipelines: [
        {
          name: 'my-codepipeline1',
          version: 1,
          pipeline_type: 'V2',
          execution_mode: 'QUEUED',
          created: Time.local(2024),
          updated: Time.local(2024)
        },
        {
          name: 'my-codepipeline2',
          version: 1,
          pipeline_type: 'V2',
          execution_mode: 'QUEUED',
          created: Time.local(2024),
          updated: Time.local(2024)
        }
      ]
    }
  }
}
