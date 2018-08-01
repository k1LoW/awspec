require 'spec_helper'
Awspec::Stub.load 'kinesis'

describe kinesis('my-kinesis') do
  it { should exist }
  its(:stream_name) { should eq 'my-kinesis' }
  its(:stream_arn) { should eq 'FIXME' }
  its(:stream_status) { should eq 'ACTIVE' }
  its(:has_more_shards) { should eq false }
  its(:retention_period_hours) { should eq 42 }
  its(:stream_creation_timestamp) { should eq 123 }
  its(:enhanced_monitoring) { should eq [
    {
      shard_level_metrics: [
        'IncomingBytes',
        'OutgoingRecords',
        'IteratorAgeMilliseconds',
        'IncomingRecords',
        'ReadProvisionedThroughputExceeded',
        'WriteProvisionedThroughputExceeded',
        'OutgoingBytes'
      ]
    }
  ] }
  its(:encryption_type) { should eq 'KMS' }
  its(:key_id) { should eq 'arn:aws:kms:us-east-2:194648440784:alias/my-kinesis-staging-default-key' }
end
