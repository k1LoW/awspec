require 'aws-sdk'

module Awspec::Helper
  module Finder
    module SNS
      def find_sns_topic(topic_name)
        sns_client = Aws::SNS::Client.new
        iam = Aws::IAM::Client.new
        client = iam.get_account_authorization_details({ max_items: 1 })
        response = client.user_detail_list[0].arn
        account = response.to_s.split(':')[4]
        wanted = "arn:aws:sns:#{sns_client.config.region}:#{account}:#{topic_name}"
        # raises "Aws::SNS::Errors::NotFound" if topic does not exist
        sns_client.get_topic_attributes({ topic_arn: wanted })
      end
    end
  end
end
