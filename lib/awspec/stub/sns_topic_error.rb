Aws.config[:sns] = {
  stub_responses: {
    get_topic_attributes: Aws::SNS::Errors::NotFound.new(
      TOPIC_ARN, 'no such topic'),
    list_subscriptions_by_topic: Aws::SNS::Errors::NotFound.new(
      TOPIC_SUBS_ARN, 'no such topic')
  }
}
