OWNER = '123456789'
REGION = 'us-east-1'
TOPIC_ARN = "arn:aws:sns:#{REGION}:#{OWNER}:foobar"
DISPLAY_NAME = 'Useless'
SUBSCRIBED = "arn:aws:sns:#{REGION}:#{OWNER}:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca"
ENDPOINT = "arn:aws:lambda:#{REGION}:#{OWNER}:function:foobar"

Aws.config[:sns] = {
  stub_responses: {
    get_topic_attributes: {
      attributes: {
        # rubocop:disable Layout/LineLength
        'Policy'                  => "{\"Version\":\"2008-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__default_statement_ID\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":[\"SNS:GetTopicAttributes\",\"SNS:SetTopicAttributes\",\"SNS:AddPermission\",\"SNS:RemovePermission\",\"SNS:DeleteTopic\",\"SNS:Subscribe\",\"SNS:ListSubscriptionsByTopic\",\"SNS:Publish\",\"SNS:Receive\"],\"Resource\":\"arn:aws:sns:#{REGION}:#{OWNER}:foobar-lambda-sample\",\"Condition\":{\"StringEquals\":{\"AWS:SourceOwner\":\"#{OWNER}\"}}}]}",
        'Owner'                   => OWNER,
        'SubscriptionsPending'    => '0',
        'TopicArn'                => TOPIC_ARN,
        'EffectiveDeliveryPolicy' => '{\"http\":{\"defaultHealthyRetryPolicy\":{\"minDelayTarget\":20,\"maxDelayTarget\":20,\"numRetries\":3,\"numMaxDelayRetries\":0,\"numNoDelayRetries\":0,\"numMinDelayRetries\":0,\"backoffFunction\":\"linear\"},\"disableSubscriptionOverrides\":false}}',
        'SubscriptionsConfirmed'  => '1',
        'DisplayName'             => DISPLAY_NAME,
        'SubscriptionsDeleted'    => '0'
      }
    },
    list_subscriptions_by_topic: {
      subscriptions: [
        {
          subscription_arn: SUBSCRIBED,
          owner: OWNER,
          protocol: 'lambda',
          endpoint: ENDPOINT,
          topic_arn: TOPIC_ARN
        }
      ],
      next_token: nil
    }
  }
}
