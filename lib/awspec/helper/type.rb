module Awspec
  module Helper
    module Type
      require 'awspec/type/base'

      TYPES = %w(
        ami autoscaling_group cloudwatch_alarm directconnect_virtual_interface
        ebs ec2 elasticache elasticache_cache_parameter_group elb iam_group
        iam_policy iam_role iam_user lambda launch_configuration nat_gateway
        network_acl network_interface rds rds_db_parameter_group route53_hosted_zone
        route_table s3_bucket security_group ses_identity subnet vpc
      )

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          name = args.first
          eval "Awspec::Type::#{type.camelize}.new(name)"
        end
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
