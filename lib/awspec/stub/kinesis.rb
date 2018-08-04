Aws.config[:kinesis] = {
  stub_responses: {
    list_streams: {
      stream_names: [
        'my-kinesis',
        'second-stream',
        'third-stream'
      ],
      has_more_streams: false
    },
    describe_stream_summary: {
      stream_description_summary: {
        stream_name: 'my-kinesis',
        stream_arn: 'arn:aws:kinesis:us-east-2:194648440784:stream/my-kinesis-staging-default-aws-resources',
        stream_status: 'ACTIVE',
        retention_period_hours: 24,
        stream_creation_timestamp: Time.at(1_529_001_577),
        enhanced_monitoring: [
          {
            shard_level_metrics: %w(
              IncomingBytes
              OutgoingRecords
              IteratorAgeMilliseconds
              IncomingRecords
              ReadProvisionedThroughputExceeded
              WriteProvisionedThroughputExceeded
              OutgoingBytes
            )
          }
        ],
        encryption_type: 'KMS',
        key_id: 'arn:aws:kms:us-east-2:194648440784:alias/my-kinesis-staging-default-key',
        open_shard_count: 1
      }
    }
  }
}
