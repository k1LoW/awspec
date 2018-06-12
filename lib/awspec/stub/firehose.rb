Aws.config[:firehose] = {
  stub_responses: {
    describe_delivery_stream: {
      delivery_stream_description: {
        delivery_stream_name: 'my-firehose',
        delivery_stream_arn: 'arn:aws:firehose:partition-1:1234567890:deliverystream/my-firehose',
        delivery_stream_status: 'Active',
        delivery_stream_type: 'DirectPut',
        version_id: '1',
        destinations: [],
        has_more_destinations: false
      }
    }
  }
}
