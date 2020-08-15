require 'aws-sdk'
require 'awspec/helper/finder/nlb'
require 'awspec/helper/finder/alb'
require 'awspec/helper/finder/vpc'
require 'awspec/helper/finder/vpc_endpoints'
require 'awspec/helper/finder/subnet'
require 'awspec/helper/finder/ec2'
require 'awspec/helper/finder/ecr'
require 'awspec/helper/finder/ecs'
require 'awspec/helper/finder/efs'
require 'awspec/helper/finder/security_group'
require 'awspec/helper/finder/rds'
require 'awspec/helper/finder/route53'
require 'awspec/helper/finder/s3'
require 'awspec/helper/finder/autoscaling'
require 'awspec/helper/finder/ebs'
require 'awspec/helper/finder/elb'
require 'awspec/helper/finder/firehose'
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
require 'awspec/helper/finder/wafregional'
require 'awspec/helper/finder/acm'
require 'awspec/helper/finder/cloudwatch_logs'
require 'awspec/helper/finder/dynamodb'
require 'awspec/helper/finder/sqs'
require 'awspec/helper/finder/cloudformation'
require 'awspec/helper/finder/ssm_parameter'
require 'awspec/helper/finder/codebuild'
require 'awspec/helper/finder/apigateway'
require 'awspec/helper/finder/kinesis'
require 'awspec/helper/finder/batch'
require 'awspec/helper/finder/eks'
require 'awspec/helper/finder/sns_topic'
require 'awspec/helper/finder/emr'
require 'awspec/helper/finder/redshift'
require 'awspec/helper/finder/codedeploy'
require 'awspec/helper/finder/mq'
require 'awspec/helper/finder/secretsmanager'
require 'awspec/helper/finder/cognito_user_pool'
require 'awspec/helper/finder/msk'
require 'awspec/helper/finder/cognito_identity_pool'

require 'awspec/helper/finder/account_attributes'

require 'awspec/helper/client_wrap'

module Awspec::Helper
  module Finder
    include Awspec::Helper::Finder::Nlb
    include Awspec::Helper::Finder::Alb
    include Awspec::Helper::Finder::Vpc
    include Awspec::Helper::Finder::VpcEndpoints
    include Awspec::Helper::Finder::Subnet
    include Awspec::Helper::Finder::Ec2
    include Awspec::Helper::Finder::Ecr
    include Awspec::Helper::Finder::Ecs
    include Awspec::Helper::Finder::Efs
    include Awspec::Helper::Finder::Firehose
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
    include Awspec::Helper::Finder::WafRegional
    include Awspec::Helper::Finder::Acm
    include Awspec::Helper::Finder::AccountAttributes
    include Awspec::Helper::Finder::CloudwatchLogs
    include Awspec::Helper::Finder::Dynamodb
    include Awspec::Helper::Finder::Sqs
    include Awspec::Helper::Finder::SsmParameter
    include Awspec::Helper::Finder::Cloudformation
    include Awspec::Helper::Finder::Codebuild
    include Awspec::Helper::Finder::Apigateway
    include Awspec::Helper::Finder::Kinesis
    include Awspec::Helper::Finder::Batch
    include Awspec::Helper::Finder::Eks
    include Awspec::Helper::Finder::SNSTopic
    include Awspec::Helper::Finder::Emr
    include Awspec::Helper::Finder::Redshift
    include Awspec::Helper::Finder::Codedeploy
    include Awspec::Helper::Finder::Mq
    include Awspec::Helper::Finder::Secretsmanager
    include Awspec::Helper::Finder::CognitoUserPool
    include Awspec::Helper::Finder::Msk
    include Awspec::Helper::Finder::CognitoIdentityPool

    CLIENTS = {
      ec2_client: Aws::EC2::Client,
      ecr_client: Aws::ECR::Client,
      ecs_client: Aws::ECS::Client,
      efs_client: Aws::EFS::Client,
      firehose_client: Aws::Firehose::Client,
      rds_client: Aws::RDS::Client,
      route53_client: Aws::Route53::Client,
      s3_client: Aws::S3::Client,
      autoscaling_client: Aws::AutoScaling::Client,
      elb_client: Aws::ElasticLoadBalancing::Client,
      elbv2_client: Aws::ElasticLoadBalancingV2::Client,
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
      waf_client: Aws::WAF::Client,
      wafregional_client: Aws::WAFRegional::Client,
      sts_client: Aws::STS::Client,
      acm_client: Aws::ACM::Client,
      cloudwatch_logs_client: Aws::CloudWatchLogs::Client,
      dynamodb_client: Aws::DynamoDB::Client,
      sqs_client: Aws::SQS::Client,
      ssm_client: Aws::SSM::Client,
      cloudformation_client: Aws::CloudFormation::Client,
      codebuild_client: Aws::CodeBuild::Client,
      apigateway_client: Aws::APIGateway::Client,
      kinesis_client: Aws::Kinesis::Client,
      batch_client: Aws::Batch::Client,
      eks_client: Aws::EKS::Client,
      sns_client: Aws::SNS::Client,
      emr_client: Aws::EMR::Client,
      redshift_client: Aws::Redshift::Client,
      codedeploy_client: Aws::CodeDeploy::Client,
      mq_client: Aws::MQ::Client,
      secretsmanager_client: Aws::SecretsManager::Client,
      msk_client: Aws::Kafka::Client,
      cognito_identity_client: Aws::CognitoIdentity::Client,
      cognito_identity_provider_client: Aws::CognitoIdentityProvider::Client
    }

    CLIENT_OPTIONS = {
      http_proxy: ENV['http_proxy'] || ENV['https_proxy'] || nil
    }

    CLIENTS.each do |method_name, client|
      define_method method_name do
        unless self.methods.include? "@#{method_name}"
          instance_variable_set(
            "@#{method_name}",
            Awspec::Helper::ClientWrap.new(client.new(CLIENT_OPTIONS))
          )
        end
      end
    end
  end
end
