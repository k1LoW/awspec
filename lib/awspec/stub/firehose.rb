Aws.config[:firehose] = {
  stub_responses: {
    describe_delivery_stream: {
      delivery_stream_description: {
        delivery_stream_name: 'my-firehose',
        delivery_stream_arn: 'arn:aws:firehose:partition-1:1234567890:deliverystream/my-firehose',
        delivery_stream_status: 'ACTIVE',
        delivery_stream_type: 'DirectPut',
        version_id: '1',
        destinations: [
          {
            destination_id: 'destination-001',
            elasticsearch_destination_description: {}
          },
          {
            destination_id: 'destination-002',
            splunk_destination_description: {}
          }
        ],
        has_more_destinations: false
      }
    }
  }
}
