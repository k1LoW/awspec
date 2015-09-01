module Awspec
  module Helper
    module Type
      TYPES = %w(
        base ec2 rds rds_db_parameter_group security_group
        vpc s3 route53_hosted_zone auto_scaling_group subnet
        route_table ebs elb lambda policy
      )

      TYPES.each do |type|
        require "awspec/type/#{type}"
        define_method type do |*args|
          name = args.first
          eval "Awspec::Type::#{type.to_camel_case}.new(name)"
        end
      end
    end
  end
end
