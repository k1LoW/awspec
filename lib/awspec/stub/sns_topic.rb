Aws.config[:sns] = {
  stub_responses: {
    get_topic_attributes: {
      attributes: {
        "Policy"=>"{\"Version\":\"2008-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__default_statement_ID\",\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":[\"SNS:GetTopicAttributes\",\"SNS:SetTopicAttributes\",\"SNS:AddPermission\",\"SNS:RemovePermission\",\"SNS:DeleteTopic\",\"SNS:Subscribe\",\"SNS:ListSubscriptionsByTopic\",\"SNS:Publish\",\"SNS:Receive\"],\"Resource\":\"arn:aws:sns:us-east-1:123456789:foobar-lambda-sample\",\"Condition\":{\"StringEquals\":{\"AWS:SourceOwner\":\"123456789\"}}}]}",
      "Owner"=>"123456789",
      "SubscriptionsPending"=>"0",
      "TopicArn"=>"arn:aws:sns:us-east-1:123456789:foobar",
      "EffectiveDeliveryPolicy"=>"{\"http\":{\"defaultHealthyRetryPolicy\":{\"minDelayTarget\":20,\"maxDelayTarget\":20,\"numRetries\":3,\"numMaxDelayRetries\":0,\"numNoDelayRetries\":0,\"numMinDelayRetries\":0,\"backoffFunction\":\"linear\"},\"disableSubscriptionOverrides\":false}}",
      "SubscriptionsConfirmed"=>"2",
      "DisplayName"=>"Useless",
      "SubscriptionsDeleted"=>"0"
      }
    }
  }
}
