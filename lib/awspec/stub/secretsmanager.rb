Aws.config[:secretsmanager] = {
  stub_responses: {
    describe_secret: {
      arn: 'my-secret-arn',
      description: 'my secret description',
      kms_key_id: 'secret-kms-key-arn',
      last_accessed_date: Time.at(1_523_923_200),
      last_changed_date: Time.at(1_523_477_145.729),
      last_rotated_date: Time.at(1_525_747_253.72),
      name: 'my-secret-name',
      rotation_enabled: true,
      rotation_lambda_arn: 'my-secret-rotation-lambda-arn',
      rotation_rules: {
        automatically_after_days: 30
      },
      tags: [
        {
          key: 'key_one',
          value: 'value_one'
        },
        {
          key: 'key_two',
          value: 'value_two'
        }
      ],
      version_ids_to_stages: {
        'EXAMPLE1-90ab-cdef-fedc-ba987EXAMPLE' => [
          'AWSPREVIOUS'
        ],
        'EXAMPLE2-90ab-cdef-fedc-ba987EXAMPLE' => [
          'AWSCURRENT'
        ]
      }
    }
  }
}
