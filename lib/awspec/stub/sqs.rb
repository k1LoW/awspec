Aws.config[:sqs] = {
  stub_responses: {
    list_queues: {
      queue_urls: [
        'https://sqs.ap-northeast-1.amazonaws.com/123456789012/my-queue',
        'https://sqs.ap-northeast-1.amazonaws.com/123456789012/my-queue2'
      ]
    },
    get_queue_attributes: {
      attributes: {
        'QueueArn' => 'arn:aws:sqs:ap-northeast-1:123456789012:my-queue',
        'ApproximateNumberOfMessages' => '0',
        'ApproximateNumberOfMessagesNotVisible' => '0',
        'ApproximateNumberOfMessagesDelayed' => '0',
        'CreatedTimestamp' => '1499422322',
        'LastModifiedTimestamp' => '1499422322',
        'VisibilityTimeout' => '30',
        'MaximumMessageSize' => '262144',
        'MessageRetentionPeriod' => '345600',
        'DelaySeconds' => '0',
        'ReceiveMessageWaitTimeSeconds' => '0'
      }
    },
    list_queue_tags: {
      tags: {
        'Name' => 'my-queue'
      }
    }
  }
}
