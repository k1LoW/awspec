module Awspec
  module Helper
    module Type
      TYPES = %w(
        base ec2 rds rds_db_parameter_group security_group
        vpc s3 s3_bucket_acl route53_hosted_zone autoscaling_group subnet
        route_table ebs elb lambda iam_user iam_group iam_role
        iam_policy elasticache elasticache_cache_parameter_group
        cloudwatch_alarm ses_identity network_acl directconnect_virtual_interface
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
    end
  end
end
