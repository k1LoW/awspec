OWNER = '123456789'
REGION = 'us-east-1'
TOPIC_ARN = "arn:aws:sns:#{REGION}:#{OWNER}:invalid"
TOPIC_SUBS_ARN = "arn:aws:sns:us-east-1:#{OWNER}:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca"

Aws.config[:sns] = {
  stub_responses: {
    get_topic_attributes: Aws::SNS::Errors::NotFound.new(
      TOPIC_ARN, 'no such topic'),
    list_subscriptions_by_topic: Aws::SNS::Errors::NotFound.new(
      TOPIC_SUBS_ARN, 'no such topic')
  }
}
