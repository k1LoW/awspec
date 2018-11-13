module Awspec::Generator
  module Doc
    module Type
      class SnsTopic < Base
        def initialize
          super
          @type_name = 'SnsTopic'
          @type = Awspec::Type::SnsTopic.new('my-sns')
          @ret = @type.resource_via_client
          @matchers = %w(include_subscribed have_subscription_attributes)
          @ignore_matchers = ['have_subscription_filter']
          @describes = %w(policy owner pending_subscriptions topic_arn effective_delivery_policy display_name
                          confirmed_subscriptions deleted_subscriptions name)
        end
      end
    end
  end
end
