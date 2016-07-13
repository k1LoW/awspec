Aws.config[:elastictranscoder] = {
  stub_responses: {
    list_pipelines: {
      pipelines: [
        {
          id: '12345678901234-a0bc4d',
          arn:
            'arn:aws:elastictranscoder:ap-northeast-1:406412696610:pipeline/12345678901234-a0bc4d',
          name: 'my-elastictranscoder-pipeline',
          status: 'Active',
          input_bucket: 'ets-input-bucket-name',
          output_bucket: 'ets-output-bucket-name',
          role: 'arn:aws:iam::01234567890:role/Elastic_Transcoder_Default_Role',
          aws_kms_key_arn: nil,
          notifications: {
            progressing: '',
            completed: '',
            warning: '',
            error: ''
          },
          content_config: {
            bucket: 'ets-output-bucket-name',
            storage_class: 'ReducedRedundancy',
            permissions: []
          },
          thumbnail_config: {
            bucket: 'ets-output-bucket-name',
            storage_class: 'ReducedRedundancy',
            permissions: []
          }
        },
        {
          id: '234567890123-9zyxv',
          arn:
            'arn:aws:elastictranscoder:ap-northeast-1:406412696610:pipeline/234567890123-9zyxv',
          name: 'yet-another-my-slastictranscoder-pipeline',
          status: 'Active',
          input_bucket: 'ya-input-bucket-name',
          output_bucket: 'ya-output-bucket-name',
          role: 'arn:aws:iam::01234567890:role/Elastic_Transcoder_Default_Role',
          aws_kms_key_arn: nil,
          notifications: {
            progressing: '',
            completed: '',
            warning: '',
            error: ''
          },
          content_config: {
            bucket: 'ya-output-bucket-name',
            storage_class: 'Standard',
            permissions: []
          },
          thumbnail_config: {
            bucket: 'ya-output-bucket-name',
            storage_class: 'Standard',
            permissions: []
          }
        }
      ],
      next_page_token: nil
    }
  }
}
