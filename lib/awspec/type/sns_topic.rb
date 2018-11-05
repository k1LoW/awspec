module Awspec::Type
  class Sns < ResourceBase
    def resource_via_client
      # resource_via_client is a Aws::SNS::Types::GetTopicAttributesResponse instance
      @resource_via_client ||= find_sns_topic(@topic_name)
    end

    def id
      # A SNS Topic doesn't have an ID...
      @id ||= resource_via_client['TopicArn'] if resource_via_client
    end
  end
end
