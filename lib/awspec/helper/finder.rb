require 'aws-sdk'
require 'awspec/helper/finder/vpc'
require 'awspec/helper/finder/subnet'
require 'awspec/helper/finder/ec2'
require 'awspec/helper/finder/ecr'
require 'awspec/helper/finder/ecs'
require 'awspec/helper/finder/security_group'
require 'awspec/helper/finder/rds'
require 'awspec/helper/finder/route53'
require 'awspec/helper/finder/s3'
require 'awspec/helper/finder/autoscaling'
require 'awspec/helper/finder/ebs'
require 'awspec/helper/finder/elb'
require 'awspec/helper/finder/lambda'
require 'awspec/helper/finder/iam'
require 'awspec/helper/finder/kms'
require 'awspec/helper/finder/elasticache'
require 'awspec/helper/finder/elasticsearch'
require 'awspec/helper/finder/cloudwatch'
require 'awspec/helper/finder/cloudwatch_event'
require 'awspec/helper/finder/ses'
require 'awspec/helper/finder/directconnect'
require 'awspec/helper/finder/ami'
require 'awspec/helper/finder/cloudfront'
require 'awspec/helper/finder/elastictranscoder'
require 'awspec/helper/finder/cloudtrail'
require 'awspec/helper/finder/waf'

module Awspec::Helper
  module Finder
    include Awspec::Helper::Finder::Vpc
    include Awspec::Helper::Finder::Subnet
    include Awspec::Helper::Finder::Ec2
    include Awspec::Helper::Finder::Ecr
    include Awspec::Helper::Finder::Ecs
    include Awspec::Helper::Finder::SecurityGroup
    include Awspec::Helper::Finder::Rds
    include Awspec::Helper::Finder::Route53
    include Awspec::Helper::Finder::S3
    include Awspec::Helper::Finder::Autoscaling
    include Awspec::Helper::Finder::Ebs
    include Awspec::Helper::Finder::Elb
    include Awspec::Helper::Finder::Lambda
    include Awspec::Helper::Finder::Iam
    include Awspec::Helper::Finder::Kms
    include Awspec::Helper::Finder::Elasticache
    include Awspec::Helper::Finder::Elasticsearch
    include Awspec::Helper::Finder::Cloudwatch
    include Awspec::Helper::Finder::CloudwatchEvent
    include Awspec::Helper::Finder::Ses
    include Awspec::Helper::Finder::Directconnect
    include Awspec::Helper::Finder::Ami
    include Awspec::Helper::Finder::Cloudfront
    include Awspec::Helper::Finder::Elastictranscoder
    include Awspec::Helper::Finder::Cloudtrail
    include Awspec::Helper::Finder::Waf

    CLIENTS = {
      ec2_client: Aws::EC2::Client,
      ecr_client: Aws::ECR::Client,
      ecs_client: Aws::ECS::Client,
      rds_client: Aws::RDS::Client,
      route53_client: Aws::Route53::Client,
      s3_client: Aws::S3::Client,
      autoscaling_client: Aws::AutoScaling::Client,
      elb_client: Aws::ElasticLoadBalancing::Client,
      lambda_client: Aws::Lambda::Client,
      iam_client: Aws::IAM::Client,
      kms_client: Aws::KMS::Client,
      elasticache_client: Aws::ElastiCache::Client,
      cloudwatch_client: Aws::CloudWatch::Client,
      cloudwatch_event_client: Aws::CloudWatchEvents::Client,
      ses_client: Aws::SES::Client,
      directconnect_client: Aws::DirectConnect::Client,
      cloudfront_client: Aws::CloudFront::Client,
      elastictranscoder_client: Aws::ElasticTranscoder::Client,
      elasticsearch_client: Aws::ElasticsearchService::Client,
      cloudtrail_client: Aws::CloudTrail::Client,
      waf_client: Aws::WAF::Client
    }

    CLIENTS.each do |method_name, client|
      define_method method_name do
        eval "@#{method_name} ||= #{client}.new"
      end
    end
  end
end
