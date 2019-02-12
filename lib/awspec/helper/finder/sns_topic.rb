module Awspec::Helper
  module Finder
    module SNSTopic
      class SnsTopic
        # to make testing results easier to the eyes instead of using Rspec
        # include matcher for hashes
        attr_reader :policy, :owner, :pending_subscriptions, :topic_arn, :effective_delivery_policy,
                    :display_name, :confirmed_subscriptions, :deleted_subscriptions, :name

        def initialize(attribs)
          @policy = attribs['Policy']
          @owner = attribs['Owner']
          @pending_subscriptions = attribs['SubscriptionsPending'].to_i
          @topic_arn = attribs['TopicArn']
          @effective_delivery_policy = attribs['EffectiveDeliveryPolicy']
          @display_name = attribs['DisplayName']
          @confirmed_subscriptions = attribs['SubscriptionsConfirmed'].to_i
          @deleted_subscriptions = attribs['SubscriptionsDeleted'].to_i
          @name = attribs['TopicArn'].split(':')[-1]
        end

        def to_s
          output = ["SnsTopic: #{self.name}"]
          self.instance_variables.each do |attrib|
            tmp = attrib.to_s.sub('@', '')
            output << "  #{tmp} = #{self.send(tmp)}"
          end
          output.join("\n")
        end
      end

      def find_sns_topic(topic_arn)
        # Find a SNS topic by searching from it's ARN.
        # Expects as parameter the SNS topic ARN.
        # Returns a Awspec::Helper::Finder::SNSTopic::SnsTopic if the topic is
        # found, nil otherwise.
        # If the SNS topic does not exist, AWS SDK throws an exception
        # which is acceptable in some cases, but in others will generate a
        # NoMethodFound during tests execution.
        # In order to avoid that and follow a uniform interface, the exception
        # will be captured and nil will be returned instead.
        # By convention, the returned object will be checked (see check_existence
        # method from Awspec::Type::Base class for an example) and an exception
        # Awspec::NoExistingResource will be raised.
        begin
          response = sns_client.get_topic_attributes({ topic_arn: topic_arn })
          topic = SnsTopic.new(response.attributes)
        rescue Aws::SNS::Errors::NotFound
          topic = nil
        end

        topic
      end

      def find_sns_topic_subs(topic_arn)
        # Find a SNS topic subscribers by searching from it's ARN.
        # Expects as parameter the SNS topic ARN.
        # Returns a map (with keys as the subscribed ARN and the value instances
        # of respective objects) if the topic is found, nil otherwise.
        # If the SNS topic does not exist, AWS SDK throws an exception
        # which is acceptable in some cases, but in others will generate a
        # NoMethodFound during tests execution.
        # In order to avoid that and follow a uniform interface, the exception
        # will be captured and nil will be returned instead.
        # By convention, the returned object will be checked (see check_existence
        # method from Awspec::Type::Base class for an example) and an exception
        # Awspec::NoExistingResource will be raised.
        begin
          response = sns_client.list_subscriptions_by_topic({ topic_arn: topic_arn })
          subscriptions = {}
          response.subscriptions.each do |subscribed|
            subscriptions[subscribed['subscription_arn'].to_sym] = subscribed
          end
        rescue Aws::SNS::Errors::NotFound
          subscriptions = nil
        end

        subscriptions
      end
    end
  end
end
