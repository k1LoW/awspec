require 'aws-sdk'
require 'awspec/helper/finder/vpc'
require 'awspec/helper/finder/ec2'
require 'awspec/helper/finder/security_group'
require 'awspec/helper/finder/rds'
require 'awspec/helper/finder/route53'
require 'awspec/helper/finder/s3'
require 'awspec/helper/finder/autoscaling'
require 'awspec/helper/finder/ebs'
require 'awspec/helper/finder/elb'
require 'awspec/helper/finder/lambda'
require 'awspec/helper/finder/iam'
require 'awspec/helper/finder/elasticache'
require 'awspec/helper/finder/cloudwatch'
require 'awspec/helper/finder/ses'
require 'awspec/helper/finder/directconnect'

module Awspec::Helper
  module Finder
    attr_reader :ec2_client
    include Awspec::Helper::Finder::Vpc
    include Awspec::Helper::Finder::Ec2
    include Awspec::Helper::Finder::SecurityGroup
    include Awspec::Helper::Finder::Rds
    include Awspec::Helper::Finder::Route53
    include Awspec::Helper::Finder::S3
    include Awspec::Helper::Finder::Autoscaling
    include Awspec::Helper::Finder::Ebs
    include Awspec::Helper::Finder::Elb
    include Awspec::Helper::Finder::Lambda
    include Awspec::Helper::Finder::Iam
    include Awspec::Helper::Finder::Elasticache
    include Awspec::Helper::Finder::Cloudwatch
    include Awspec::Helper::Finder::Ses
    include Awspec::Helper::Finder::Directconnect

    CLIENTS = {
      ec2_client: Aws::EC2::Client,
      rds_client: Aws::RDS::Client,
      route53_client: Aws::Route53::Client,
      s3_client: Aws::S3::Client,
      autoscaling_client: Aws::AutoScaling::Client,
      elb_client: Aws::ElasticLoadBalancing::Client,
      lambda_client: Aws::Lambda::Client,
      iam_client: Aws::IAM::Client,
      elasticache_client: Aws::ElastiCache::Client,
      cloudwatch_client: Aws::CloudWatch::Client,
      ses_client: Aws::SES::Client,
      directconnect_client: Aws::DirectConnect::Client
    }

    CLIENTS.each do |method_name, client|
      define_method method_name do
        eval "@#{method_name} ||= #{client}.new"
      end
    end
  end
end
