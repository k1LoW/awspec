module Awspec::Type
  class SnsTopic < ResourceBase
    def initialize(topic_arn)
      super
      @topic_arn = topic_arn
      @subscriptions = nil
    end

    def resource_via_client
      @resource_via_client ||= find_sns_topic(@topic_arn)
    end

    def id
      # A SNS Topic doesn't have an ID...
      @id ||= resource_via_client.topic_arn if resource_via_client
    end

    def list_subscriptions()
      if @subscriptions.nil?
        @subscriptions = find_sns_topic_subs(@topic_arn)
      end
      @subscriptions
    end

    def subscribed(subscribed_arn)
      subs_key = subscribed_arn.to_sym
      if @subscriptions.has_key?(subs_key)
        return @subscriptions[subs_key]
      else
        raise "'#{subscribed_arn}' is not a valid subscription ARN"
      end
    end

    def method_missing(method_name)
      # delegates the method invocation to Awspec::Helper::Finder::SnsTopic::SnsTopic class
      @resource_via_client.send method_name
    end
  end
end
