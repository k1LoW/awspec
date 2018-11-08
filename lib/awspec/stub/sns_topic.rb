Aws.config[:sns] = {
  stub_responses: {
    get_topic_attributes: {
      attributes: {
        # rubocop:disable LineLength
        'Policy'                  => '{\"Version\":\"2008-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__default_statement_ID\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":[\"SNS:GetTopicAttributes\",\"SNS:SetTopicAttributes\",\"SNS:AddPermission\",\"SNS:RemovePermission\",\"SNS:DeleteTopic\",\"SNS:Subscribe\",\"SNS:ListSubscriptionsByTopic\",\"SNS:Publish\",\"SNS:Receive\"],\"Resource\":\"arn:aws:sns:us-east-1:123456789:foobar-lambda-sample\",\"Condition\":{\"StringEquals\":{\"AWS:SourceOwner\":\"123456789\"}}}]}',
        'Owner'                   => '123456789',
        'SubscriptionsPending'    => '0',
        'TopicArn'                => 'arn:aws:sns:us-east-1:123456789:foobar',
        'EffectiveDeliveryPolicy' => '{\"http\":{\"defaultHealthyRetryPolicy\":{\"minDelayTarget\":20,\"maxDelayTarget\":20,\"numRetries\":3,\"numMaxDelayRetries\":0,\"numNoDelayRetries\":0,\"numMinDelayRetries\":0,\"backoffFunction\":\"linear\"},\"disableSubscriptionOverrides\":false}}',
        'SubscriptionsConfirmed'  => '1',
        'DisplayName'             => 'Useless',
        'SubscriptionsDeleted'    => '0'
      }
    },
    list_subscriptions_by_topic: {
      subscriptions: [
        {
          subscription_arn: 'arn:aws:sns:us-east-1:123456789:Foobar:3dbf4999-b3e2-4345-bd11-c34c9784ecca',
          owner: '123456789',
          protocol: 'lambda',
          endpoint: 'arn:aws:lambda:us-east-1:123456789:function:foobar',
          topic_arn: 'arn:aws:sns:us-east-1:123456789:foobar'
        }
      ],
      next_token: nil
    }
  }
}
