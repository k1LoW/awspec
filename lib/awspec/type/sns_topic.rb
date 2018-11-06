module Awspec::Type
  class SnsTopic < ResourceBase
    def initialize(name)
      super
      @topic_name = name
    end

    def resource_via_client
      @resource_via_client ||= find_sns_topic(@topic_name)
    end

    def id
      # A SNS Topic doesn't have an ID...
      @id ||= resource_via_client if resource_via_client.topic_arn
    end

    def method_missing(method_name)
      # delegates the method invocation to Awspec::Helper::Finder::SnsTopic::SnsTopic class
      @resource_via_client.send method_name
    end
  end
end
