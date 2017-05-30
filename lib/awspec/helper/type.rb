module Awspec
  module Helper
    module Type
      require 'awspec/type/base'
      require 'awspec/type/resource_base'
      require 'awspec/type/account_attribute_base'
      require 'awspec/type/account'
      require 'awspec/type/account_attribute'

      TYPES = %w(
        alb ami autoscaling_group cloudtrail cloudwatch_alarm cloudwatch_event directconnect_virtual_interface
        ebs ec2 ecr_repository ecs_cluster ecs_container_instance ecs_service ecs_task_definition
        efs elasticache elasticache_cache_parameter_group elasticsearch elb iam_group
        iam_policy iam_role iam_user kms lambda launch_configuration nat_gateway
        network_acl network_interface rds rds_db_cluster_parameter_group rds_db_parameter_group route53_hosted_zone
        route_table s3_bucket security_group ses_identity subnet vpc cloudfront_distribution
        elastictranscoder_pipeline waf_web_acl customer_gateway vpn_gateway vpn_connection internet_gateway acm
        cloudwatch_logs dynamodb_table eip
      )

      ACCOUNT_ATTRIBUTES = %w(
        ec2_account_attributes rds_account_attributes lambda_account_settings ses_send_quota
      )

      def class_from_string(str)
        str.split('::').inject(Object) do |mod, class_name|
          mod.const_get(class_name)
        end
      end

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          unless Object.const_get("Awspec::Type::#{type.camelize}").superclass.to_s == 'Awspec::Type::ResourceBase'
            raise "Awspec::Type::#{type.camelize} should extend Awspec::Type::ResourceBase"
          end
          class_from_string("Awspec::Type::#{type.camelize}").new(args.first)
        end
      end

      ACCOUNT_ATTRIBUTES.each do |type|
        require "awspec/type/#{type}"
        define_method type do
          unless Object.const_get("Awspec::Type::#{type.camelize}").superclass.to_s \
                 == 'Awspec::Type::AccountAttributeBase'
            raise "Awspec::Type::#{type.camelize} should extend Awspec::Type::AccountAttributeBase"
          end
          class_from_string("Awspec::Type::#{type.camelize}").new
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
