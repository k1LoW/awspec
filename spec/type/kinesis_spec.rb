# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'kinesis'

describe kinesis('my-kinesis') do
  it { should exist }
  its(:stream_name) { should eq 'my-kinesis' }
  its(:stream_arn) do
    should eq 'arn:aws:kinesis:us-east-2:194648440784:stream/my-kinesis-staging-default-aws-resources'
  end
  its(:stream_status) { should eq 'ACTIVE' }
  its(:retention_period_hours) { should eq 24 }
  its(:stream_creation_timestamp) { should eq Time.at(1_529_001_577) }
  its(:encryption_type) { should eq 'KMS' }
  its(:key_id) { should eq 'arn:aws:kms:us-east-2:194648440784:alias/my-kinesis-staging-default-key' }
  its(:open_shard_count) { should eq 1 }

  # FIXME: this one needs more testing
  # its(:enhanced_monitoring) {
  #   should eq [{
  #     shard_level_metrics: [
  #       'IncomingBytes',
  #       'OutgoingRecords',
  #       'IteratorAgeMilliseconds',
  #       'IncomingRecords',
  #       'ReadProvisionedThroughputExceeded',
  #       'WriteProvisionedThroughputExceeded',
  #       'OutgoingBytes'
  #       ]
  #     }]
  #   }
end
