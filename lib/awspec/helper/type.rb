module Awspec
  module Helper
    module Type
      require 'awspec/type/base'

      TYPES = %w(
        autoscaling_group cloudwatch_alarm directconnect_virtual_interface
        ebs ec2 elasticache elasticache_cache_parameter_group elb iam_group
        iam_policy iam_role iam_user lambda nat_gateway network_acl rds
        rds_db_parameter_group route53_hosted_zone route_table
        s3_bucket security_group ses_identity subnet vpc
      )

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          name = args.first
          eval "Awspec::Type::#{type.camelize}.new(name)"
        end
      end

      # deprecated resource type
      def auto_scaling_group(name)
        puts ''
        puts Color.on_red(Color.white('!!! `auto_scaling_group` type is deprecated. use `autoscaling_group` !!!'))
        Awspec::Type::AutoscalingGroup.new(name)
      end

      def s3(name)
        puts ''
        puts Color.on_red(Color.white('!!! `s3` type is deprecated. use `s3_bucket` !!!'))
        Awspec::Type::S3Bucket.new(name)
      end
    end
  end
end
