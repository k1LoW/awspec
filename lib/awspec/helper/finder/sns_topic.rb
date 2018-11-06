module Awspec::Helper
  module Finder
    module SNSTopic
      class SnsTopic
        # to make testing results easier to the eyes instead of using Rspec
        # include matcher for hashes
        attr_reader :policy, :owner, :pending_subscriptions, :topic_arn, :effective_delivery_policy,
                    :display_name, :confirmed_subscriptions, :deleted_subscriptions

        def initialize(attribs)
          @policy = attribs['Policy']
          @owner = attribs['Owner']
          @pending_subscriptions = attribs['SubscriptionsPending'].to_i
          @topic_arn = attribs['TopicArn']
          @effective_delivery_policy = attribs['EffectiveDeliveryPolicy']
          @display_name = attribs['DisplayName']
          @confirmed_subscriptions = attribs['SubscriptionsConfirmed'].to_i
          @deleted_subscriptions = attribs['SubscriptionsDeleted'].to_i
        end

        def to_s
          output = ['SnsTopic:']
          self.instance_variables.each do |attrib|
            tmp = attrib.to_s.sub('@', '')
            output << "  #{tmp} = #{self.send(tmp)}"
          end
          output.join("\n")
        end
      end

      def find_sns_topic(topic_name)
        response = sns_client.get_topic_attributes({ topic_arn: topic_name })
        SnsTopic.new(response.attributes)
      end
    end
  end
end
