module Awspec
  module Helper
    module Type
      require 'awspec/type/base'
      require 'awspec/type/resource_base'
      require 'awspec/type/account_attribute_base'
      require 'awspec/type/account'
      require 'awspec/type/account_attribute'

      TYPES = %w(
        alb alb_listener alb_target_group ami apigateway autoscaling_group
        batch_compute_environment batch_job_definition batch_job_queue cloudtrail
        cloudwatch_alarm cloudwatch_event directconnect_virtual_interface
        ebs ec2 ecr_repository ecs_cluster ecs_container_instance ecs_service ecs_task_definition
        efs eks elasticache elasticache_cache_parameter_group elasticsearch elb emr firehose iam_group
        iam_policy iam_role iam_user kinesis kms lambda launch_configuration launch_template mq nat_gateway
        network_acl network_interface nlb nlb_listener nlb_target_group
        rds rds_db_cluster_parameter_group rds_db_parameter_group route53_hosted_zone
        route_table s3_bucket security_group ses_identity subnet vpc cloudfront_distribution
        elastictranscoder_pipeline waf_web_acl wafregional_web_acl customer_gateway vpn_gateway vpn_connection
        internet_gateway acm cloudwatch_logs dynamodb_table eip sqs ssm_parameter cloudformation_stack
        codebuild sns_topic redshift redshift_cluster_parameter_group codedeploy codedeploy_deployment_group
        secretsmanager msk transit_gateway cognito_identity_pool cognito_user_pool vpc_endpoints
      )

      ACCOUNT_ATTRIBUTES = %w(
        ec2_account_attributes rds_account_attributes lambda_account_settings ses_send_quota
      )

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          unless Object.const_get("Awspec::Type::#{type.camelize}").superclass.to_s == 'Awspec::Type::ResourceBase'
            raise "Awspec::Type::#{type.camelize} should extend Awspec::Type::ResourceBase"
          end
          name = args.first
          eval "Awspec::Type::#{type.camelize}.new(name)"
        end
      end

      ACCOUNT_ATTRIBUTES.each do |type|
        require "awspec/type/#{type}"
        define_method type do
          unless Object.const_get("Awspec::Type::#{type.camelize}").superclass.to_s \
                 == 'Awspec::Type::AccountAttributeBase'
            raise "Awspec::Type::#{type.camelize} should extend Awspec::Type::AccountAttributeBase"
          end
          eval "Awspec::Type::#{type.camelize}.new"
        end
      end

      def account
        Awspec::Type::Account.new
      end

      def account_attribute(key)
        Awspec::Type::AccountAttribute.new(key)
      end

      def self.deprecate_resource_type(old_type, new_type)
        define_method(old_type) do |*args, &block|
          puts ''
          warn Color.on_red(Color.white("!!! `#{old_type}` type is deprecated. use `#{new_type}` !!!"))
          send(new_type, *args, &block)
        end
      end

      deprecate_resource_type :auto_scaling_group, :autoscaling_group
      deprecate_resource_type :s3, :s3_bucket
    end
  end
end
