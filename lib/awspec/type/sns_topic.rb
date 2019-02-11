module Awspec::Type
  class SnsTopic < ResourceBase
    def initialize(topic_arn)
      super
      @topic_arn = topic_arn
      # lazy instantiation
      @subscriptions = nil
    end

    def subscriptions
      fetch_subscriptions
      @subscriptions.keys
    end

    def resource_via_client
      @resource_via_client ||= find_sns_topic(@topic_arn)
    end

    def id
      # A SNS Topic doesn't have an ID...
      @id ||= resource_via_client.topic_arn if resource_via_client
    end

    def has_subscription?(subscribed_arn)
      fetch_subscriptions
      @subscriptions.key?(subscribed_arn.to_sym)
    end

    def subscribed(subscribed_arn)
      subs_key = subscribed_arn.to_sym
      fetch_subscriptions
      raise "'#{subscribed_arn}' is not a valid subscription ARN" unless @subscriptions.key?(subs_key)
      @subscriptions[subs_key]
    end

    def method_missing(method_name)
      check_existence
      # delegates the method invocation to Awspec::Helper::Finder::SnsTopic::SnsTopic class
      @resource_via_client.send method_name
    end

    private

    def fetch_subscriptions
      @subscriptions = find_sns_topic_subs(@topic_arn) if @subscriptions.nil?
      raise Awspec::NoExistingResource.new(self.class, @display_name) if @subscriptions.nil?
      @subscriptions
    end
  end
end
